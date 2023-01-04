//
//  BaseViewControllerProtocol.swift
//  BaseVIPER
//
//  Created on 25/3/22.
//

import Foundation

public protocol BaseViewControllerProtocol: AnyObject {
    var basePresenter: BasePresenterProtocol? { get set }
}
