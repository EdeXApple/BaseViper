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

protocol HomeViewProtocol: BaseViewProtocol {
    func setViewModel(_ viewModel: HomeViewModel)
}

class HomeViewController: BaseViewController {
    
    var presenter: HomePresenterProtocol? { super.basePresenter as? HomePresenterProtocol }
   
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        UIInterfaceOrientation.portrait
    }
    var tableViewManager: TableViewManager?
    var collectionViewManager: CollectionViewManager?
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var userImage: UIImageView!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    // MARK: VIPER Dependencies

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.accessibilityIdentifier = "table"
        self.tableViewManager = TableViewManager(arrayTableViews: [CustomTableView(tableView: self.tableView)],
                                                 presenter: self.presenter,
                                                 drawer: OptionCellDrawer.self)
        self.collectionViewManager = CollectionViewManager(arrayCollectionViews: [CustomCollectionView(collectionView: self.collectionView)],
                                                           presenter: self.presenter,
                                                           drawer: OptionCollectionCellDrawer.self)
        initializeUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func initializeUI() {
        self.userImage.roundCorners(corners: [.allCorners], radius: 64)
    }
}

extension HomeViewController: HomeViewProtocol {

    func setViewModel(_ viewModel: HomeViewModel) {
        self.nameLabel.text = viewModel.name
        self.usernameLabel.text = viewModel.username
        self.emailLabel.text = viewModel.email
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        self.clipsToBounds = true
    }
}
