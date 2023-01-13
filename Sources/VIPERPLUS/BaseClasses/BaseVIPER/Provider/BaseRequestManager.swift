//
//  BaseRequestManager.swift
//  BaseVIPER
//
//  Created on 24/3/22.
//

import Foundation

/// <#Description#>
public protocol BaseRequestManager {
    ///
    var delegate: BaseProviderDelegate? { get set }
    
    /// <#Description#>
    /// - Returns: <#description#>
    func request(requestDto: BaseProviderDTO,
                 completion: @escaping (Result<Data?, BaseErrorModel>) -> Void) -> URLSessionTask?
}
