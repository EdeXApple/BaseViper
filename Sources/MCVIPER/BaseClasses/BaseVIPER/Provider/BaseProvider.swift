/*
Copyright, everisSL
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

import UIKit

/// <#Description#>
open class BaseProvider {
    
    ///
    public var task: URLSessionTask?
    ///
    public weak var delegate: BaseProviderDelegate?
    ///
    public var manager: BaseRequestManager?
    
    /// <#Description#>
    public required init() {}
    
    /// <#Description#>
    /// - Parameters:
    ///   - requestDto: <#requestDto description#>
    ///   - completion: <#completion description#>
    /// - Returns: <#description#>
    public func request(requestDto: BaseProviderDTO,
                        completion: @escaping (Result<Data?, BaseErrorModel>) -> Void) -> URLSessionTask? {
        if !NetworkManager.shared.checkNetwork() {
            completion(.failure(BaseErrorModel(httpClientError: HTTPClientError.ErrorType.networkError,
                                               backendError: BackendError.ErrorType.unknownError)))
            self.delegate?.networkNotReachable()
            return nil
        }
        let endpoint = requestDto.domain + requestDto.endpoint

        if !requestDto.flagsDto.isSecure {
            BaseProviderUtils.removeCookies(forURL: URL(string: endpoint)!)
        } else {
            BaseProviderUtils.storeCookies(CookiesManager.shared.cookies, forURL: URL(string: endpoint)!)
        }
        if var manager = self.manager {
            manager.delegate = self.delegate
            
            let request = manager.request(requestDto: requestDto) { result in
                switch result {
                case .success(let data):
                    if requestDto.flagsDto.isLogin {
                        if let url = URL(string: endpoint) {
                            CookiesManager
                                .shared
                                .cookies = BaseProviderUtils
                                .readCookie(
                                    forURL: url)
                        }
                    }
                    DispatchQueue.main.async {
                        completion(.success(data))
                    }

                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
            self.task = request
            return request
        } else {
            let customError: BaseErrorModel
            customError = BaseErrorModel(httpClientError: .notFound, backendError: .invalidUserData)
            completion(.failure(customError))
            return nil
        }
    }
}
