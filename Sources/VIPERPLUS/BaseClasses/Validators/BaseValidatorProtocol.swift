//
//  BaseValidatorProtocol.swift
//  BaseVIPER
//
//  Created on 24/3/22.
//

import Foundation

protocol BaseValidatorProtocol: AnyObject {
    
    var arrayValidations: [(String?) -> ValidationErrorType] { get set }
    var errors: [ValidationErrorType] { get set }
    
    func validate(_ text: String?) -> [ValidationErrorType]?
}
