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
import UIKit

// MARK: - dto
struct LoginAssemblyDTO {
}
// MARK: - module builder
final class LoginAssembly: BaseAssembly {

    static func navigationController(dto: LoginAssemblyDTO? = nil) -> UINavigationController {
         UINavigationController(rootViewController: view(dto: dto))
    }

    static func view(dto: LoginAssemblyDTO? = nil) -> LoginViewController {
        let view = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let viper = BaseAssembly.assembly(baseView: view,
                                          presenter: LoginPresenter.self,
                                          router: LoginRouter.self,
                                          interactor: LoginInteractor.self)
        viper.interactor.assemblyDTO = dto
        
        if ProcessInfo.processInfo.environment["ENV"] == "TEST" {
        viper.interactor.provider = DataAssembly.provider(providerType: LoginProviderMock.self,
                                                          protocolType: LoginProviderProtocol.self,
                                                          interactor: viper.interactor)
        } else {
       
        viper.interactor.provider = DataAssembly.provider(providerType: LoginProvider.self,
                                                          protocolType: LoginProviderProtocol.self,
                                                          interactor: viper.interactor)
        }
        return view
    }
}
