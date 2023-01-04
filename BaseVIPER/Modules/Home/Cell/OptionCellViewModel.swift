//
//  OptionCellViewModel.swift
//  BaseVIPER
//
//  Created on 22/4/22.
//

import ComponentUIKit
import Foundation
import MCVIPER

class OptionCellViewModel: BaseTableViewCellModelProtocol {
    var identifier: String = "OptionTableViewCell"
    
    var labelName: String?
    
    init() {
    }
    
    init(labelName: String) {
        self.labelName = labelName
    }
}
