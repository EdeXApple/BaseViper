//
//  HTTPClientError.swift
//  BaseVIPER
//
//  Created on 24/3/22.
//

import Foundation

public class HTTPClientError: Error {
    
    public struct ErrorType: RawRepresentable, Equatable {
        public var rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        public static let internalServerError = ErrorType(rawValue: 500)
        public static let badGateway = ErrorType(rawValue: 502)
        public static let unauthorized = ErrorType(rawValue: 401)
        public static let forbidden = ErrorType(rawValue: 403)
        public static let notFound = ErrorType(rawValue: 404)
        public static let preConditionFailed = ErrorType(rawValue: 412)
        public static let networkError = ErrorType(rawValue: 0)
        public static let unknownError = ErrorType(rawValue: -1)
        public static let timeout = ErrorType(rawValue: -1001)
        public static let parse = ErrorType(rawValue: -2)
    }
    
//    public enum ErrorType: Int {
//        case internalServerError = 500
//        case badGateway = 502
//        case unauthorized = 401
//        case forbidden = 403
//        case notFound = 404
//        case preConditionFailed = 412
//        case networkError = 0
//        case unknownError = -1
//        case timeout = -1001
//        case parse = -2
//    }
    
    public var type: ErrorType = .unknownError

    public init(code: Int = -1) {
        self.type = ErrorType(rawValue: code)
    }
}
