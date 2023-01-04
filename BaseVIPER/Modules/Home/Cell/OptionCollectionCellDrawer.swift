//
//  OptionCollectionCellDrawer.swift
//  BaseVIPER
//
//  Created on 9/5/22.
//

import ComponentUIKit
import Foundation
import UIKit

class OptionCollectionCellDrawer: BaseCollectionCellDrawerProtocol {
    
    static func cell(model: BaseCollectionViewCellModelProtocol,
                     collectionView: UICollectionView,
                     delegate: Any?,
                     indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = BaseCollectionViewCell<Any>.createBaseCell(collectionView: collectionView,
                                                                    cell: OptionCollectionViewCell.self,
                                                                    cellName: model.identifier,
                                                                    model: model,
                                                                    indexPath: indexPath) else {
            
            return UICollectionViewCell()
        }
        return cell
    }
}
