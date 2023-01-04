//
//  BaseProviderDTO.swift
//  BaseVIPER
//
//  Created on 24/3/22.
//

import Foundation

/// <#Description#>

public struct AcceptResponseType: RawRepresentable, Equatable {
    public var rawValue: String
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    public static let json = AcceptResponseType(rawValue: "json")
    public static let pdf = AcceptResponseType(rawValue: "pdf")
    public static let xml = AcceptResponseType(rawValue: "xml")
    public static let text = AcceptResponseType(rawValue: "text")
}

//public enum AcceptResponseType {
//    ///
//    case json
//    ///
//    case pdf
//    ///
//    case xml
//    ///
//    case text
//}

public struct HTTPMethod: RawRepresentable, Equatable {
    public var rawValue: String
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    public static let options = HTTPMethod(rawValue: "OPTIONS")
    public static let get = HTTPMethod(rawValue: "GET")
    public static let head = HTTPMethod(rawValue: "HEAD")
    public static let post = HTTPMethod(rawValue: "POST")
    public static let put = HTTPMethod(rawValue: "PUT")
    public static let patch = HTTPMethod(rawValue: "PATCH")
    public static let delete = HTTPMethod(rawValue: "DELETE")
    public static let trace = HTTPMethod(rawValue: "TRACE")
    public static let connect = HTTPMethod(rawValue: "CONNECT")
}

/// <#Description#>
//public enum HTTPMethod: String {
//    ///
//    case options = "OPTIONS"
//    ///
//    case get     = "GET"
//    ///
//    case head    = "HEAD"
//    ///
//    case post    = "POST"
//    ///
//    case put     = "PUT"
//    ///
//    case patch   = "PATCH"
//    ///
//    case delete  = "DELETE"
//    ///
//    case trace   = "TRACE"
//    ///
//    case connect = "CONNECT"
//}

/// <#Description#>
public class BaseProviderDTO {
    ///
    public var params: [String: Any]?
    ///
    public var arrayParams: [[String: Any]]?
    ///
    public var method: HTTPMethod
    ///
    public var domain: String
    ///
    public var endpoint: String
    ///
    public var acceptType = AcceptResponseType.json
    ///
    public var baseUrl: String
    ///
    public var additionalHeader: [String: String]
    ///
    public var flagsDto: BaseFlagsProviderDTO
    
    /// <#Description#>
    /// - Parameters:
    ///   - params: <#params description#>
    ///   - method: <#method description#>
    ///   - domain: <#domain description#>
    ///   - endpoint: <#endpoint description#>
    ///   - baseUrl: <#baseUrl description#>
    ///   - acceptType: <#acceptType description#>
    ///   - additionalHeader: <#additionalHeader description#>
    ///   - flagsDto: <#flagsDto description#>
    public init(params: [String: Any]?,
                method: HTTPMethod,
                domain: String,
                endpoint: String,
                baseUrl: String,
                acceptType: AcceptResponseType = .json,
                additionalHeader: [String: String] = [:],
                flagsDto: BaseFlagsProviderDTO = BaseFlagsProviderDTO()) {
        
        self.params = params
        self.method = method
        self.domain = domain
        self.endpoint = endpoint
        self.baseUrl = baseUrl
        self.acceptType = acceptType
        self.additionalHeader = additionalHeader
        self.flagsDto = flagsDto
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - arrayParams: <#arrayParams description#>
    ///   - method: <#method description#>
    ///   - endpoint: <#endpoint description#>
    ///   - domain: <#domain description#>
    ///   - baseUrl: <#baseUrl description#>
    ///   - acceptType: <#acceptType description#>
    ///   - additionalHeader: <#additionalHeader description#>
    ///   - flagsDto: <#flagsDto description#>
    public init(arrayParams: [[String: Any]]?,
                method: HTTPMethod,
                endpoint: String,
                domain: String,
                baseUrl: String,
                acceptType: AcceptResponseType = .json,
                additionalHeader: [String: String] = [:],
                flagsDto: BaseFlagsProviderDTO = BaseFlagsProviderDTO()) {
        self.arrayParams = arrayParams
        self.method = method
        self.domain = domain
        self.endpoint = endpoint
        self.baseUrl = baseUrl
        self.acceptType = acceptType
        self.additionalHeader = additionalHeader
        self.flagsDto = flagsDto
    }
}
