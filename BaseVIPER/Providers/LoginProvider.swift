/// Copyright (c) 2023 EdeX Apple
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import MCVIPER

struct LoginProviderRequest {
    struct Params: BaseServerModel {
        let username: String?
        let password: String?
    }
    
    var params: Params?
    var headers: [String: String]?
    
    static func getRequest(params: BaseServerModel?, headers: [String: String]? = nil) -> BaseProviderDTO {
        BaseProviderDTO(params: params?.encode(), method: .post, domain: "", endpoint: "/login", baseUrl: "https://arq-viper.herokuapp.com")
    }
}

protocol LoginProviderProtocol {
    func login(request: LoginProviderRequest, completion: @escaping (Result<LoginServerModel, BaseErrorModel>) -> Void)
}

final class LoginProvider: BaseProvider, LoginProviderProtocol {
    
    func login(request: LoginProviderRequest, completion: @escaping (Result<LoginServerModel, BaseErrorModel>) -> Void) {
        _ = self.request(requestDto: LoginProviderRequest.getRequest(params: request.params, headers: request.headers),
                         completion: { result in
            switch result {
            case .success(let data):
                guard let serverModel = BaseProviderUtils.parseToServerModel(parserModel: LoginServerModel.self, data: data) else {
                    completion(.failure(BaseErrorModel(httpClientError: .parse, backendError: .unknownError)))
                    return
                }
                completion(.success(serverModel))
                
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
