//
//  BaseRouterDelegate.swift
//  BaseVIPER
//
//  Created on 25/3/22.
//

import Foundation

// Delegate used to report that a navigation has been done. It will usually be implemented by the Presenter
public protocol BaseRouterDelegate: AnyObject {
    func navigationDone()
}
