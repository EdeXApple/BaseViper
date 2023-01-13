//
//  BasePresenterProtocol.swift
//  BaseVIPER
//
//  Created on 25/3/22.
//

import Foundation

// Protocol used to the View can communicate with Presenter
public protocol BasePresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear(isFirstPresentation: Bool)
    func viewDidAppear(isFirstPresentation: Bool)
}

extension BasePresenterProtocol {
    
    /// <#Description#>
    public func viewDidLoad() {
        // Optional method
    }
    
    /// <#Description#>
    /// - Parameter isFirstPresentation: <#isFirstPresentation description#>
    public func viewWillAppear(isFirstPresentation: Bool) {
        // Optional method
    }
    
    /// <#Description#>
    /// - Parameter isFirstPresentation: <#isFirstPresentation description#>
    public func viewDidAppear(isFirstPresentation: Bool) {
        // Optional method
    }
}
