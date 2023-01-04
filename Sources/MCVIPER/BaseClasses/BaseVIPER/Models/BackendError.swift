//
//  BackendError.swift
//  BaseVIPER
//
//  Created on 24/3/22.
//

import Foundation

public class BackendError: Error {
    
    public struct ErrorType: RawRepresentable, Equatable {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        public static let loginAttempsExceeded = ErrorType(rawValue: "AUTH0001")
        public static let userNotFound = ErrorType(rawValue: "WAM002")
        public static let invalidUserData = ErrorType(rawValue: "WAM013")
        public static let userAlreadyRegistered = ErrorType(rawValue: "WAM015")
        public static let tokenInvalid = ErrorType(rawValue: "AUTH0006")
        public static let unknownError = ErrorType(rawValue: "")
      
    }
    
//    public enum ErrorType: String {
//        case loginAttempsExceeded = "AUTH0001"
//        case userNotFound = "WAM002"
//        case invalidUserData = "WAM013"
//        case userAlreadyRegistered = "WAM015"
//        case tokenInvalid = "AUTH0006"
//        case unknownError = ""
//    }
    
    public var type: ErrorType = .unknownError
    public var code: String = ""
    public var serverMessage = ""
    public var errorText = ""

    public init(code: String = "", serverMessage: String) {
        
        self.type = ErrorType(rawValue: code)
        self.errorText = Self.getErrorTextFrom(self.type)
        self.serverMessage = serverMessage
    }
    
    public static func getErrorTextFrom(_ type: ErrorType) -> String {
    
        switch type {
        case .loginAttempsExceeded:
            return "login_error_blocked_user"

        case .userNotFound:
            return "username_forgotten_error_username_not_found"

        case .invalidUserData:
            return "username_forgotten_error_username_data_invalid"

        case .userAlreadyRegistered:
            return "registration_user_validation_error_user_already_registered"

        default:
            return "error_generic"
        }
    }
}
