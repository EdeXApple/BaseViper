//
//  BaseRouterTests.swift
//  
//
//  Created by EdexApple on 23/5/22.
//

import VIPERPLUS
import XCTest

class BaseRouterTests: XCTestCase {

    var router: BaseRouter!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        router = BaseRouter()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        router = nil
    }
}
