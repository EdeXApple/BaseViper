//
//  OptionCollectionViewCell.swift
//  BaseVIPER
//
//  Created by Jose Antonio Romero Dueñas on 9/5/22.
//

import ComponentUIKit
import UIKit

class OptionCollectionViewCell: BaseCollectionViewCell<OptionCollectionCellViewModel> {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func configure(cellModel: OptionCollectionCellViewModel) {
        super.configure(cellModel: cellModel)
        label.text = cellModel.labelName
        containerView.backgroundColor = .white
    }
}
