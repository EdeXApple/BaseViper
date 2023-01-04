//
//  OptionCellDrawe.swift
//  BaseVIPERSample
//
//  Created on 22/4/22.
//

import ComponentUIKit
import Foundation
import UIKit

class OptionCellDrawer: BaseCellDrawerProtocol {
    
    static func cell(model: BaseTableViewCellModelProtocol, tableView: UITableView, delegate: Any?) -> UITableViewCell {
        guard let cell = BaseTableViewCell<Any>.createBaseCell(tableView: tableView,
                                                               cell: OptionTableViewCell.self,
                                                               cellName: model.identifier,
                                                               model: model) else {
            return UITableViewCell()
        }
        return cell
    }
}
