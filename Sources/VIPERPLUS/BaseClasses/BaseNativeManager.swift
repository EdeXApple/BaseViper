/*
Copyright, EDEXApple
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
*/

import Foundation
import Security

open class BaseNativeManager: NSObject, BaseRequestManager {
    
    struct RestEntity {
        private var values: [String: Any] = [:]
        
        mutating func add(value: Any, forKey key: String) {
            values[key] = value
        }
        func value(forKey key: String) -> Any? {
            values[key]
        }
        func allValues() -> [String: Any] {
            values
        }
        func totalItems() -> Int {
            values.count
        }
    }
    
    var certificateName: String?
    var certificateExtension: String?
    public weak var delegate: BaseProviderDelegate?
    
    var requestHttpHeaders = RestEntity()
    var urlQueryParameters = RestEntity()
    var httpBodyParameters = RestEntity()
    
    /// <#Description#>
    /// - Parameters:
    ///   - certificateName: <#certificateName description#>
    ///   - certificateExtension: <#certificateExtension description#>
    public init(certificateName: String?,
                certificateExtension: String?) {
        
        self.certificateName = certificateName
        self.certificateExtension = certificateExtension
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - requestDto: <#requestDto description#>
    ///   - completion: <#completion description#>
    /// - Returns: <#description#>
    public func request(requestDto: BaseProviderDTO,
                        completion: @escaping (Result<Data?, BaseErrorModel>) -> Void) -> URLSessionTask? {
        
        requestHttpHeaders = RestEntity()
        urlQueryParameters = RestEntity()
        httpBodyParameters = RestEntity()
        
        let endpoint = requestDto.baseUrl + requestDto.endpoint
        
        for currentHeader in requestDto.additionalHeader {
            requestHttpHeaders.add(value: currentHeader.value, forKey: currentHeader.key)
        }
        var targetURL = URL(string: endpoint)

        if let params = requestDto.params {
            params.forEach({ item in
                let value: String = (item.value as? String) ?? "\(item.value)"
                // Si no se especific el Content-Type, se tratan como parámetros en la URL...
                if requestDto.additionalHeader["Content-Type"] == nil {
                    urlQueryParameters.add(value: value, forKey: item.key)
                    targetURL = self.addURLQueryParameters(toURL: URL(string: endpoint)!)
                } else {
                    // Si se especifica, se incluyen en el body
                    httpBodyParameters.add(value: value, forKey: item.key)
                }
            })
        }
        
        let httpBody: Data? = requestDto.method != .get ? self.getHttpBody(requestDto: requestDto) : nil
        guard let request = self.prepareRequest(withURL: targetURL,
                                                httpBody: httpBody,
                                                httpMethod: requestDto.method) else {
            completion(.failure(BaseErrorModel(httpClientError: .unknownError, backendError: .unknownError)))
            return nil
        }
        if requestDto.flagsDto.showLoader {
            DispatchQueue.main.async {
                self.delegate?.requestDone()
            }
        }
        let session = createSession(requestDto: requestDto)
//        let task = createTask(session: session,
//                              request: request,
//                              requestDto: requestDto,
//                              success: success,
//                              failure: failure)
        let task = createTask(session: session,
                              request: request,
                              requestDto: requestDto,
                              completion: completion)
        
        task.resume()
        return task
    }
    
    // MARK: - Private Methods
    
    private func createTask(session: URLSession,
                            request: URLRequest,
                            requestDto: BaseProviderDTO,
                            completion: @escaping (Result<Data?, BaseErrorModel>) -> Void) -> URLSessionTask {
        let task = session.dataTask(with: request) { data, response, error in
            if error == nil {
                if let httpResponse = response as? HTTPURLResponse {
                    
                    BaseProviderUtils.manageResponse(flagsDto: requestDto,
                                                     response: httpResponse,
                                                     data: data,
                                                     delegate: self.delegate) { result in
                        
                        if requestDto.flagsDto.showLoader {
                            DispatchQueue.main.async {
                                self.delegate?.responseGet()
                            }
                        }
                        switch result {
                        case .success(let data):
                            completion(.success(data))

                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                } else {
                    if requestDto.flagsDto.showLoader {
                        DispatchQueue.main.async {
                            self.delegate?.responseGet()
                        }
                    }
                    completion(.failure(BaseErrorModel(error: error)))
                }
            } else {
                completion(.failure(BaseErrorModel(error: error)))
            }
        }
        return task
    }
    
    private func createSession(requestDto: BaseProviderDTO) -> URLSession {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = requestDto.flagsDto.timeout
        sessionConfiguration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        return URLSession(configuration: sessionConfiguration,
                          delegate: requestDto.flagsDto.trustAll ? nil : self,
                          delegateQueue: nil)
    }
    
    private func addURLQueryParameters(toURL url: URL) -> URL {
        if urlQueryParameters.totalItems() > 0 {
            guard var urlComponents = URLComponents(url: url,
                                                    resolvingAgainstBaseURL: false) else {
                return url
            }
            var queryItems = [URLQueryItem]()
            if urlComponents.queryItems == nil {
                urlComponents.queryItems = queryItems
            }
            
            for (key, value) in urlQueryParameters.allValues() {
                let item = URLQueryItem(name: key,
                                        value: "\(value)".addingPercentEncoding(
                                            withAllowedCharacters: .urlQueryAllowed))
                queryItems.append(item)
                urlComponents.queryItems?.append(item)
            }
            guard let updatedURL = urlComponents.url else {
                return url
            }
            return updatedURL
        }
        return url
    }
    
    private func getHttpBody(requestDto: BaseProviderDTO? = nil) -> Data? {
        guard let contentType = requestHttpHeaders.value(forKey: "Content-Type") as? String else {
            return nil
        }
        if contentType.contains("application/json") {
            if let requestDtoUnw = requestDto {
                return try? JSONSerialization.data(withJSONObject: (requestDtoUnw.params ?? [:]),
                                                   options: [.prettyPrinted, .sortedKeys])
            } else {
                let body = try? JSONSerialization.data(withJSONObject: httpBodyParameters.allValues(),
                                                       options: [.prettyPrinted, .sortedKeys])
                return body
            }
        } else if contentType.contains("application/x-www-form-urlencoded") {
            let bodyString = httpBodyParameters.allValues()
                .map { "\($0)=\(String(describing: "\($1)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!))" }
                .joined(separator: "&")
            return bodyString.data(using: .utf8)
        } else {
            return nil
        }
    }
    
    private func prepareRequest(withURL url: URL?, httpBody: Data?, httpMethod: HTTPMethod) -> URLRequest? {
        guard let url = url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        for (header, value) in requestHttpHeaders.allValues() {
            request.setValue("\(value)", forHTTPHeaderField: header)
        }
        request.httpBody = httpBody
        return request
    }
}

extension BaseNativeManager: URLSessionDelegate {
    public func urlSession(_ session: URLSession,
                           didReceive challenge: URLAuthenticationChallenge,
                           completionHandler:
                           @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let certificateName = self.certificateName,
              let certificateExtension = self.certificateExtension else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        guard let serverTrust = challenge.protectionSpace.serverTrust,
              let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0) else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        // Políticas SSL para la verificación del nombre de dominio
        let policy = NSMutableArray()
        policy.add(SecPolicyCreateSSL(true, challenge.protectionSpace.host as CFString))
        // validar el certificado del servidor
        var isServerTrusted: Bool = false
        let result: SecTrustResultType = .invalid
        if #available(iOS 12, *) {
            isServerTrusted = SecTrustEvaluateWithError(serverTrust, nil)
        } else {
            if result == .unspecified || result == .proceed {
                isServerTrusted = true
            }
        }
        // FIX: Cambiar los NSData por Data y probar que sigue funcionando
        // Datos del certificado local y remoto
        let remoteCertificateData: NSData = SecCertificateCopyData(certificate)
        guard let pathToLocalCertificate = Bundle.main.path(forResource: certificateName,
                                                            ofType: certificateExtension),
              let localCertificateData = NSData(contentsOfFile: pathToLocalCertificate) else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        // Compara los certificados
        if isServerTrusted && remoteCertificateData.isEqual(to: localCertificateData as Data) {
            let credential: URLCredential = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, credential)
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
}
