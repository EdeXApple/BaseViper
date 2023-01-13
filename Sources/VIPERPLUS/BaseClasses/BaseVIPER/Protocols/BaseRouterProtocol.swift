//
//  BaseRouterProtocol.swift
//  BaseVIPER
//
//  Created on 25/3/22.
//

import Foundation

// Protocol used to the Presenter can communicate with Router
public protocol BaseRouterProtocol: AnyObject {
    func showErrorModalWith(title: String,
                            message: String,
                            action: BaseAlertAction?,
                            completion: (() -> Void)?)
    func showAlertWith(title: String?,
                       message: String?,
                       actions: [BaseAlertAction]?)
    func showOptionsModal(title: String?,
                          message: String?,
                          completion: (() -> Void)?)
}

extension BaseRouterProtocol {
    
    /// <#Description#>
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - message: <#message description#>
    ///   - action: <#action description#>
    ///   - completion: <#completion description#>
    public func showErrorModalWith(title: String,
                                   message: String,
                                   action: BaseAlertAction?,
                                   completion: (() -> Void)?) {}
    
    /// <#Description#>
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - message: <#message description#>
    ///   - actions: <#actions description#>
    public func showAlertWith(title: String?,
                              message: String?,
                              actions: [BaseAlertAction]?) {}
    
    /// <#Description#>
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - message: <#message description#>
    ///   - completion: <#completion description#>
    public func showOptionsModal(title: String?,
                                 message: String?,
                                 completion: (() -> Void)? = nil) {}
}
