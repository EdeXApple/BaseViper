//
//  OptionTableViewCell.swift
//  BaseVIPERSample
//
//  Created on 22/4/22.
//

import ComponentUIKit
import UIKit

class OptionTableViewCell: BaseTableViewCell<OptionCellViewModel> {

    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func configure(cellModel: OptionCellViewModel) {
        super.configure(cellModel: cellModel)
        label.text = cellModel.labelName
        view.backgroundColor = .primary
    }
}
