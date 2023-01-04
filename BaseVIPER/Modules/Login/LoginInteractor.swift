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
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
*/

import Foundation
import MCVIPER

protocol LoginInteractorInputProtocol: BaseInteractorInputProtocol {

    var assemblyDTO: LoginAssemblyDTO? { get }
    
    func login(username: String, password: String)
}

final class LoginInteractor: BaseInteractor {
    
    // MARK: VIPER Dependencies
    weak var presenter: LoginInteractorOutputProtocol? { super.basePresenter as? LoginInteractorOutputProtocol }
    var provider: LoginProviderProtocol?
    var assemblyDTO: LoginAssemblyDTO?
}

extension LoginInteractor: LoginInteractorInputProtocol {
    
    func login(username: String, password: String) {
        self.provider?.login(request: LoginProviderRequest(params: LoginProviderRequest.Params(username: username, password: password), headers: nil),
                             completion: { result in
            switch result {
            case .success(let serverModel):
                print(serverModel.userToken ?? "", serverModel.nickname ?? "")
                // Se ha aplicado tdd, tenía el test antes, me fallaba porque no había puesto aquí la llamada a userlogged
                guard let businessModel = BaseInteractor.parseToBusinessModel(parserModel: LoginBusinessModel.self, serverModel: serverModel) else {
                    
                    return
                }
                self.presenter?.userLogged(loginData: businessModel)
            
            case .failure(let error):
                print(error)
            }
        })
    }
}
