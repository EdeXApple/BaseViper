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

protocol HomePresenterProtocol: BasePresenterProtocol {
}

protocol HomeInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func userInformationRecovered(_ userInformation: HomeBusinessModel)
}

final class HomePresenter: BasePresenter {
    
    // MARK: VIPER Dependencies
    weak var view: HomeViewProtocol? { super.baseView as? HomeViewProtocol }
    var router: HomeRouterProtocol? { super.baseRouter as? HomeRouterProtocol }
    var interactor: HomeInteractorInputProtocol? { super.baseInteractor as? HomeInteractorInputProtocol }
    
    weak var tablePresenterDelegate: TablePresenterDelegate?
    weak var collectionPresenterDelegate: CollectionPresenterDelegate?
    
    var businessModel: HomeBusinessModel?
    // MARK: Private Functions
    func viewDidLoad() {
        self.interactor?.getUserData()
    }
    
    func viewWillAppear(isFirstPresentation: Bool) {
    }
}

extension HomePresenter: HomePresenterProtocol {
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func userInformationRecovered(_ userInformation: HomeBusinessModel) {
        self.businessModel = userInformation
        guard let viewModel = BasePresenter.parseToViewModel(parserModel: HomeViewModel.self,
                                                             businessModel: userInformation) else {
            return
        }
        self.view?.setViewModel(viewModel)
        self.tablePresenterDelegate?.dataSourceUpdated(nil)
        self.collectionPresenterDelegate?.dataSourceUpdated(nil)
    }
}

extension HomePresenter: TablePresenterProtocol {
    
    func heightForRow(_ tableIdentifier: String?, indexPath: IndexPath) -> Int? {
        80
    }
    
    func numberOfRows(_ tableIdentifier: String?, section: Int) -> Int {
        guard let viewModel = BasePresenter.parseToViewModel(parserModel: HomeViewModel.self,
                                                             businessModel: self.businessModel) else {
            return 0
        }
        return viewModel.dataSource?.count ?? 0
    }
    
    func objectForRow(_ tableIdentifier: String?, indexPath: IndexPath) -> Any {
        guard let viewModel = BasePresenter.parseToViewModel(parserModel: HomeViewModel.self,
                                                             businessModel: self.businessModel) else {
            return []
        }
        
        return viewModel.dataSource?[indexPath.row] ?? []
    }
    
    func didTapRow(_ tableIdentifier: String?, indexPath: IndexPath) {
        self.router?.navigateToLogin()
    }
}

extension HomePresenter: CollectionPresenterProtocol {
    
    func numberOfCells(_ collectionIdentifier: String?, section: Int) -> Int {
        guard let viewModel = BasePresenter.parseToViewModel(parserModel: HomeViewModel.self,
                                                             businessModel: self.businessModel) else {
            return 0
        }
        return viewModel.collectionDataSource?.count ?? 0
    }
    
    func object(_ collectionIdentifier: String?, indexPath: IndexPath) -> Any {
        guard let viewModel = BasePresenter.parseToViewModel(parserModel: HomeViewModel.self,
                                                             businessModel: self.businessModel) else {
            return []
        }
        
        return viewModel.collectionDataSource?[indexPath.row] ?? []
    }
    
    func cellSize(_ collectionIdentifier: String?, indexPath: IndexPath) -> (width: Float, height: Float) {
        (width: 128, height: 64)
    }
    
    func minimumInteritemSpace(_ collectionIdentifier: String?) -> Int {
        16
    }
}
