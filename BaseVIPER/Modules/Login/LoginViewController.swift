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
import MCVIPER
import UIKit

protocol LoginViewProtocol: BaseViewProtocol {
}

class LoginViewController: BaseViewController {
    // MARK: VIPER Dependencies
    var presenter: LoginPresenterProtocol? { super.basePresenter as? LoginPresenterProtocol }
    var userTextFieldManager: TextFieldManager?
    
    @IBOutlet private weak var userTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTextField.accessibilityIdentifier = "userTextField"
        passwordTextField.accessibilityIdentifier = "passwordTextField"
        loginButton.accessibilityIdentifier = "loginButton"
        
        self.userTextFieldManager = TextFieldManager(textField: self.userTextField,
                                                     presenter: self.presenter,
                                                     formType: TextFieldModel(.mesaARQ),
                                                     nextTextField: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction private func loginButtonPressed(_ sender: Any) {
        
        guard let username = userTextField.text, let password = passwordTextField.text else {
            self.presenter?.fieldsRequired()
            return
        }
        if username.isEmpty || password.isEmpty {
            self.presenter?.fieldsRequired()
        } else {
            self.presenter?.loginButtonPressed(username: username, password: password)
        }
    }
}

extension LoginViewController: LoginViewProtocol {
}
