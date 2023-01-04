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
import ComponentUIKit
import Foundation
import MCVIPER

protocol LoginPresenterProtocol: BasePresenterProtocol {
    func loginButtonPressed(username: String, password: String)
    func fieldsRequired()
}

protocol LoginInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func userLogged(loginData: LoginBusinessModel)
}

final class LoginPresenter: BasePresenter {
    
    // MARK: VIPER Dependencies
    weak var view: LoginViewProtocol? { super.baseView as? LoginViewProtocol }
    var router: LoginRouterProtocol? { super.baseRouter as? LoginRouterProtocol }
    var interactor: LoginInteractorInputProtocol? { super.baseInteractor as? LoginInteractorInputProtocol }
        
    // MARK: Private Functions
    func viewDidLoad() {
    }
    
    func viewWillAppear(isFirstPresentation: Bool) {
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    func fieldsRequired() {
        self.view?.showToast(viewModel: ToastViewModel(type: .error, title: "Hay campos requeridos", icon: .strokedCheckmark, containerColor: .error))
    }
    
    func loginButtonPressed(username: String, password: String) {
        self.interactor?.login(username: username, password: password)
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func userLogged(loginData: LoginBusinessModel) {
        self.view?.showToast(viewModel: ToastViewModel(type: .success,
                                                       title: "Usuario Logado",
                                                       icon: .checkmark,
                                                       containerColor: .success))
    }
}

extension LoginPresenter: TextFieldPresenterProtocol {
    func textFieldDidBeginEditing(textFieldModel: TextFieldModel, text: String?) {
        print("He empezado a escribir en mi textfield")
        print(text ?? "")
    }
    
    func textFieldDidChange(textFieldModel: TextFieldModel, text: String?) {
        print("Mi textfield ha cambiado")
        print(text ?? "")
    }
    
    func textFieldDidEndEditing(textFieldModel: TextFieldModel, text: String?) {
        print("Terminé de escribir")
        print(text ?? "")
        print(textFieldModel.type)
        print(textFieldModel.type.rawValue)
        
        switch textFieldModel.type {
        case .nickname:
            print("campo de texto correcto")
            
        case .mesaARQ:
            print("tipo añadido por extension")
            
        default:
            break
        }
    }
}

extension TextFieldModel.TextFieldType {
    static let mesaARQ = TextFieldModel.TextFieldType(rawValue: "mesaARQ")
}
