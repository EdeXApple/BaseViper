//
//  ValidationErrorType.swift
//  BaseVIPER
//
//  Created on 24/3/22.
//

import Foundation

//public enum ValidationErrorType: String {
//    case empty
//    case wrongEmail
//    case wrongFormat
//    case charactersLimit
//    case none
//}

public struct ValidationErrorType: RawRepresentable, Equatable {
    public var rawValue: String = ""
    public init(rawValue: String = "") {
        self.rawValue = rawValue
    }
    public static let empty = ValidationErrorType()
    public static let wrongEmail = ValidationErrorType()
    public static let wrongFormat = ValidationErrorType()
    public static let charactersLimit = ValidationErrorType()
    public static let none = ValidationErrorType()
}
