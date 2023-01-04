//
//  DataAssembly.swift
//  BaseVIPERSample
//
//  Created by Jose Antonio Romero Dueñas on 31/3/22.
//

import Foundation

/// Struct to build providers
public struct DataAssembly {
    
    /// Static method to return a provider
    /// - Parameters:
    ///    - providerType: Type of provider that we want to build
    ///    - protocolType: protocol of provider that we want to build
    ///    - interactor: Interactor of our VIPER module which will inject as dependency
    ///    - manager: Manager of request, as default native manager, but we can choose other like AlamofireManager.
    /// - Returns: Provider as protocol which have types of parameters
    
    public static func provider<Provider: BaseProvider, Protocol: Any>(
        providerType: Provider.Type,
        protocolType: Protocol.Type,
        interactor: BaseInteractor,
        manager: BaseRequestManager? = BaseNativeManager(certificateName: nil,
                                                         certificateExtension: nil)) -> Protocol? {
        
        let provider = Provider()

        provider.delegate = interactor
        provider.manager = manager
        provider.manager?.delegate = interactor

        return provider as? Protocol
    }
}
