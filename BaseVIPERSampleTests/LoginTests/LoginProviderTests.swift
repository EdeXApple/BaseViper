//
//  LoginProvider.swift
//  BaseVIPERSampleTests
//
//  Created by EdexApple on 20/5/22.
//

@testable import BaseVIPERSample
import Foundation
import MCVIPER
import XCTest

class LoginProviderTests: XCTestCase {
    private var provider = LoginProvider()
    
    func testLoginRequestSuccess() {
        provider.manager = BaseNativeManager(certificateName: nil, certificateExtension: nil)
        let waiter = XCTWaiter()
        let expectation = XCTestExpectation(description: "Esperar a que termine el servicio y nos devuelva el resultado")
        
        let request = LoginProviderRequest(params: LoginProviderRequest.Params(username: "jromerdu", password: "123456"), headers: nil)
        
        provider.login(request: request) { result in
            XCTAssertEqual(result, .success(LoginServerModel(userToken: "FNO112U48923NF", nickname: "UnitTest")))
        }
        waiter.wait(for: [expectation], timeout: 3)
    }
    
    func testLoginRequestFail() {
        
        let waiter = XCTWaiter()
        let expectation = XCTestExpectation(description: "Esperar a que termine el servicio y nos devuelva el resultado")
        
        let request = LoginProviderRequest(params: LoginProviderRequest.Params(username: "jromerdu", password: "123456"), headers: nil)
        
        provider.login(request: request) { result in
            
            XCTAssertEqual(result, .failure(BaseErrorModel(data: nil, httpCode: 404)))
            waiter.wait(for: [expectation], timeout: 5)
        }
    }
    
    func testParseDataToServerModel() {
        let serverModel = LoginServerModel(userToken: "FNO112U48923NF", nickname: "UnitTest")
        let model = serverModel.encode()
        let data = try? JSONSerialization.data(withJSONObject: model)
        
        XCTAssertEqual(BaseProviderUtils.parseToServerModel(parserModel: LoginServerModel.self, data: data), serverModel)
    }
}
