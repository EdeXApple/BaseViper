//
//  BaseViewProtocol.swift
//  BaseVIPER
//
//  Created on 25/3/22.
//

import Foundation

// Protocol used to the Presenter can communicate with View
public protocol BaseViewProtocol: AnyObject {
    func showLoading(fullScreen: Bool)
    func hideLoading()
}

extension BaseViewProtocol {
    
    /// <#Description#>
    /// - Parameter fullScreen: <#fullScreen description#>
    public func showLoading(fullScreen: Bool) {
        // Optional method
    }
    
    /// <#Description#>
    public func hideLoading() {
        // Optional method
    }
}
