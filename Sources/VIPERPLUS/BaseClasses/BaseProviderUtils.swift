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

/// <#Description#>
open class BaseProviderUtils {
    
    ///
    public static let dateFormat = "dd/MM/yyyy-HH:mm:ss"
    
    /// <#Description#>
    /// - Parameters:
    ///   - requestDto: <#requestDto description#>
    ///   - endpoint: <#endpoint description#>
    ///   - headers: <#headers description#>
    ///   - printData: <#printData description#>
    public static func printRequest(requestDto: BaseProviderDTO,
                                    endpoint: String,
                                    headers: [String: Any],
                                    printData: Bool = false) {
        let data = requestDto.arrayParams != nil
            ? try? JSONSerialization
            .data(withJSONObject: (requestDto
                                    .arrayParams ?? [:]), options:
                                                .prettyPrinted)
            : try? JSONSerialization
            .data(withJSONObject: (requestDto
                                    .params ?? []), options:
                        .prettyPrinted)
        if printData {

            print("************* REQUEST **************")
            print("Request Date: \(Self.format(date: Date(), format: dateFormat))")
            print("URL: \(endpoint)")
            print("PARAMETERS: ")
            print(String(data: data ?? Data(), encoding: .utf8) ?? "")
            print("HEADERS: \(headers)")
            print("************* END *************")
        }
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - endpoint: <#endpoint description#>
    ///   - data: <#data description#>
    ///   - decryptedBytes: <#decryptedBytes description#>
    ///   - printData: <#printData description#>
    public static func printSuccessResponse(endpoint: String,
                                            data: Data,
                                            decryptedBytes: Data?,
                                            printData: Bool = false) {
        if printData {
            print("*************************** RESPONSE ***************************")
            print("Response Date: \(Self.format(date: Date(), format: dateFormat))")
            print("URL: \(endpoint)")
            print(String(data: data, encoding: .utf8) ?? "")
            print("********* END ***********")
        }
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - endpoint: <#endpoint description#>
    ///   - data: <#data description#>
    ///   - decryptedBytes: <#decryptedBytes description#>
    ///   - printData: <#printData description#>
    public static func printFailureResponse(endpoint: String,
                                            data: Data?,
                                            decryptedBytes: Data?,
                                            printData: Bool = false) {
        if printData {
            print("*************************** RESPONSE ***************************")
            print("Response Date: \(Self.format(date: Date(), format: dateFormat))")
            print("URL: \(endpoint)")
            print(String(data: data ?? Data(), encoding: .utf8) ?? "")
        }
     }
    
    /// <#Description#>
    /// - Parameters:
    ///   - data: <#data description#>
    ///   - encrypted: <#encrypted description#>
    /// - Returns: <#description#>
    public static func manageResponseData(data: Data?,
                                          encrypted: Bool) -> Data? {
        guard let data = data else {
            return nil
        }
        var decryptedBytes: Data?
        if encrypted {
        } else {
            decryptedBytes = data
        }
        return decryptedBytes
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - responseData: <#responseData description#>
    ///   - responseStatusCode: <#responseStatusCode description#>
    ///   - failure: <#failure description#>
    public static func apiResponseError(responseData: Data?,
                                        responseStatusCode: Int?,
                                        printData: Bool = false,
                                        failure: @escaping (BaseErrorModel) -> Void) {
        let customError: BaseErrorModel
        customError = BaseErrorModel(data: responseData, httpCode: responseStatusCode)
		
        if printData {
            print(customError)
            print("*************************** END ***************************")
        }
        
        failure(customError)
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - responseData: <#responseData description#>
    ///   - responseStatusCode: <#responseStatusCode description#>
    /// - Returns: <#description#>
    public static func apiResponseError(responseData: Data?,
                                        responseStatusCode: Int?,
                                        printData: Bool = false) -> BaseErrorModel {
        
        if printData {
            print(BaseErrorModel(data: responseData, httpCode: responseStatusCode))
            print("*************************** END ***************************")
        }
        
        return BaseErrorModel(data: responseData, httpCode: responseStatusCode)
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    public static func parseToServerModel<M: BaseServerModel>(parserModel: M.Type,
                                                              data: Data?) -> M? {
        guard let payload = data else {
            return nil
        }
        var model: M?
        do {
            model = try JSONDecoder().decode(parserModel, from: payload)
        } catch {
        }
        return model
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    public static func parseArrayToServerModel<M: BaseServerModel>(parserModel: [M].Type,
                                                                   data: Data?) -> [M]? {
        guard let payload = data,
                let arrayModels = try? JSONDecoder().decode(
                    parserModel,
                    from: payload) else {
            return nil
        }
        return arrayModels
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - flagsDto: <#flagsDto description#>
    ///   - response: <#response description#>
    ///   - data: <#data description#>
    ///   - delegate: <#delegate description#>
    ///   - completion: <#completion description#>
    public static func manageResponse(flagsDto: BaseProviderDTO,
                                      response: HTTPURLResponse,
                                      data: Data?,
                                      delegate: BaseProviderDelegate?,
                                      completion: @escaping (Result<Data?, BaseErrorModel>) -> Void) {
        DispatchQueue.main.async {
            delegate?.responseGet()
        }
        if flagsDto.flagsDto.printLog {
            print(response.statusCode)
        }
        if (200..<300).contains(response.statusCode) {
            guard let data = data else {
                completion(.failure(self.apiResponseError(responseData: nil,
                                                          responseStatusCode: response.statusCode,
                                                          printData: flagsDto.flagsDto.printLog)))

                return
            }

            let decryptedBytes = Self.manageResponseData(data: data,
                                                         encrypted: flagsDto.flagsDto.encrypted)
            printSuccessResponse(endpoint: flagsDto.endpoint,
                                 data: data,
                                 decryptedBytes: decryptedBytes,
                                 printData: flagsDto.flagsDto.printLog)
            
            completion(.success(decryptedBytes))
        } else {
            let decryptedBytes = Self.manageResponseData(data: data,
                                                         encrypted: flagsDto.flagsDto.encrypted)
            printFailureResponse(endpoint: flagsDto.endpoint,
                                 data: data,decryptedBytes: decryptedBytes,
                                 printData: flagsDto.flagsDto.printLog)
            completion(.failure(self.apiResponseError(responseData: decryptedBytes,
                                                      responseStatusCode: response.statusCode,
                                                      printData: flagsDto.flagsDto.printLog)))

            return
        }
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - name: <#name description#>
    ///   - withExtension: <#withExtension description#>
    ///   - forClass: <#forClass description#>
    /// - Returns: <#description#>
    public static func getData(name: String, withExtension: String = "json", forClass: AnyClass) -> Data? {
        let bundle = Bundle(for: forClass)
        let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
        let data = try? Data(contentsOf: fileUrl!)
        return data
    }
    
    /// <#Description#>
    /// - Parameter response: <#response description#>
    public static func setCookies(response: URLResponse) {
        if let httpResponse = response as? HTTPURLResponse {
            if let headerFields = httpResponse.allHeaderFields as? [String: String] {
                let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields,
                                                 for: response.url!)
                storeCookies(cookies, forURL: response.url!)
            }
        }
    }
    
    static func storeCookies(_ cookies: [HTTPCookie],
                             forURL url: URL) {
        let cookieStorage = HTTPCookieStorage.shared
        cookieStorage.setCookies(cookies,
                                 for: url,
                                 mainDocumentURL: nil)
    }

    static func readCookie(forURL url: URL) -> [HTTPCookie] {
        let cookieStorage = HTTPCookieStorage.shared
        let cookies = cookieStorage.cookies(for: url) ?? []
        return cookies
    }
    
    static func removeCookies(forURL url: URL) {
        let cookieStorage = HTTPCookieStorage.shared
        for cookie in readCookie(forURL: url) {
            cookieStorage.deleteCookie(cookie)
        }
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - identifier: <#identifier description#>
    ///   - format: <#format description#>
    /// - Returns: <#description#>
    private static func format(date: Date, format: String = dateFormat) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
}
