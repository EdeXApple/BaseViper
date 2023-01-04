//
//  OptionCollectionCellViewModel.swift
//  BaseVIPER
//
//  Created by Jose Antonio Romero Dueñas on 9/5/22.
//

import ComponentUIKit
import Foundation
import MCVIPER

class OptionCollectionCellViewModel: BaseCollectionViewCellModelProtocol {
    var identifier: String = "OptionCollectionViewCell"
    
    var labelName: String?
    
    init() {
    }
    
    init(labelName: String) {
        self.labelName = labelName
    }
}
