//
//  BaseProviderDelegate.swift
//  BaseVIPER
//
//  Created on 25/3/22.
//

import Foundation

// Delegate used to report actions with web services. It will usually be implemented by the Interactor
public protocol BaseProviderDelegate: AnyObject {
    func requestDone()
    func responseGet()
    func networkNotReachable()
}
