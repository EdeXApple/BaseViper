//
//  BaseValidatorProtocol+Extension.swift
//  BaseVIPER
//
//  Created on 24/3/22.
//

import Foundation

extension BaseValidatorProtocol {
    
    func validate(_ text: String?) -> [ValidationErrorType]? {
        errors.removeAll()
        for validation in arrayValidations {
            self.errors.append(validation(text))
            self.errors.append(self.charactersLimit(text, partialRangeFrom: 3...))
        }
        return self.checkErrors()
    }

    internal func checkErrors() -> [ValidationErrorType]? {
        self.errors.contains(where: { $0 != .none }) ? self.errors : nil
//        self.errors.filter({ $0 != .none }).isEmpty ? nil : self.errors
    }
    
    internal func validateWithRegularExpression(regularExpresion: String,
                                                value: String) -> Bool {
        if let regExpression = try? NSRegularExpression(pattern: regularExpresion,
                                                        options: NSRegularExpression.Options.caseInsensitive) {
            let firstMatchRange = regExpression
                .rangeOfFirstMatch(in: value,
                                   options: .anchored,
                                   range: NSRange(location: 0,
                                                  length: value.count))
            if NSEqualRanges(firstMatchRange, NSRange(location: NSNotFound,
                                                      length: 0)) {
                return false
            } else {
                return true
            }
        }
        return false
    }
    
    internal func isEmpty(_ text: String?) -> ValidationErrorType {
        text?.isEmpty ?? false ? .empty : .none
    }
    
    internal func lastIsNumber(_ text: String?) -> ValidationErrorType {
        text?.last?.isNumber ?? false ? .empty : .none
    }
    
    internal func isNumber(_ text: String?) -> ValidationErrorType {
        (Int(text ?? "") != nil) ? .none : .wrongFormat
    }
    
    internal func charactersLimit(_ text: String?,
                                  closedRange: ClosedRange<Int>) -> ValidationErrorType {
          
        closedRange.contains(text?.count ?? 0) ? .none : .charactersLimit
    }
    
    internal func charactersLimit(_ text: String?,
                                  partialRangeFrom: PartialRangeFrom<Int>) -> ValidationErrorType {
          
        partialRangeFrom.contains(text?.count ?? 0) ? .none : .charactersLimit
    }
}
