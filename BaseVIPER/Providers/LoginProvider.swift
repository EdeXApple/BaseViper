/*
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THEs
POSSIBILITY OF SUCH DAMAGE.
*/

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
