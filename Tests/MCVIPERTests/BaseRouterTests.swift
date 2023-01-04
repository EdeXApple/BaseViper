//
//  BaseRouterTests.swift
//  
//
//  Created by Jose Antonio Romero Dueñas on 23/5/22.
//

import MCVIPER
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
