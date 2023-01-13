//
//  BaseInteractorOutputProtocol.swift
//  BaseVIPER
//
//  Created on 25/3/22.
//

import Foundation

// Protocol used to the Interactor can communicate with Presenter
public protocol BaseInteractorOutputProtocol: AnyObject {
    func genericErrorHappened(error: BaseErrorModel)
    func asyncTaskStarted()
    func asyncTaskFinished()
    func networkErrorHappened()
}

extension BaseInteractorOutputProtocol {
    
    /// <#Description#>
    /// - Parameter error: <#error description#>
    public func genericErrorHappened(error: BaseErrorModel) {}
    
    /// <#Description#>
    public func asyncTaskStarted() {}
    
    /// <#Description#>
    public func asyncTaskFinished() {}
    
    /// <#Description#>
    public func networkErrorHappened() {}
}
