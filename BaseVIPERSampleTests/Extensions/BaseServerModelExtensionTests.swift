//
//  BaseServerModelExtensionTests.swift
//  BaseVIPERSampleTests
//
//  Created by Jose Antonio Romero Dueñas on 19/5/22.
//

@testable import BaseVIPERSample
import Foundation
import MCVIPER
import XCTest

class BaseServerModelExtensionTests: XCTestCase {
    func testEncodeServerModel() {
        let user = LoginServerModel(userToken: "test", nickname: "test")
        
        let model = user.encode()
        let data = try? JSONSerialization.data(withJSONObject: model)
        let decodeUser = BaseProviderUtils.parseToServerModel(parserModel: LoginServerModel.self, data: data)
        XCTAssertEqual(user, decodeUser)
    }
    
    func testEncodeArrayServerModel() throws {
        let users = [LoginServerModel(userToken: "test", nickname: "test"),
                     LoginServerModel(userToken: "test1", nickname: "test1"),
                     LoginServerModel(userToken: "test2", nickname: "test2")]
        
        let model = users.encode()
        let data = try XCTUnwrap(JSONSerialization.data(withJSONObject: model))
        let decodeUser = BaseProviderUtils.parseArrayToServerModel(parserModel: [LoginServerModel].self, data: data)
        XCTAssertEqual(users, decodeUser)
    }
}
