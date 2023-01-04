//
//  File.swift
//  BaseVIPERSampleTests
//
//  Created by Jose Antonio Romero Dueñas on 12/5/22.
//
//

import Foundation
import MCVIPER

class LoginProviderMock: BaseProvider, LoginProviderProtocol {
    
    func login(request: LoginProviderRequest, completion: @escaping (Result<LoginServerModel, BaseErrorModel>) -> Void) {
        
        completion(.success(LoginServerModel(userToken: "1234", nickname: "Alias")))
        if request.params?.username == "jromerdu" && request.params?.password == "123456" {
                    completion(.success(LoginServerModel(userToken: "1234", nickname: "Alias")))
                } else {
                    completion(.failure(BaseErrorModel(httpClientError: .unauthorized, backendError: .userNotFound)))
                }
            }
}
