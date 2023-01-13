//
//  BaseFlagsProviderDTO.swift
//  BaseVIPER
//
//  Created on 24/3/22.
//

import Foundation

/// <#Description#>
public class BaseFlagsProviderDTO {
    ///
    public var isSecure: Bool
    ///
    public var isLogin: Bool
    ///
    public var printLog: Bool
    ///
    public var encrypted: Bool
    ///
    public var timeout: TimeInterval
    ///
    public var trustAll: Bool
    ///
    public var showLoader: Bool
    
    /// <#Description#>
    /// - Parameters:
    ///   - isSecure: <#isSecure description#>
    ///   - isLogin: <#isLogin description#>
    ///   - printLog: <#printLog description#>
    ///   - encrypted: <#encrypted description#>
    ///   - timeout: <#timeout description#>
    ///   - trustAll: <#trustAll description#>
    ///   - showLoader: <#showLoader description#>
    public init(isSecure: Bool = false,
                isLogin: Bool = false,
                printLog: Bool = true,
                encrypted: Bool = false,
                timeout: TimeInterval = 15,
                trustAll: Bool = true,
                showLoader: Bool = true) {
        self.timeout = timeout
        self.printLog = printLog
        self.encrypted = encrypted
        self.isSecure = isSecure
        self.isLogin = isLogin
        self.trustAll = trustAll
        self.showLoader = showLoader
    }
}
