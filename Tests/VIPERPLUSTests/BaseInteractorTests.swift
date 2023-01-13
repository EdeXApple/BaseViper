//
//  BaseInteractorTests.swift
//  
//
//  Created by EdexApple on 23/5/22.
//

import VIPERPLUS
import XCTest

struct UserServerModel: BaseServerModel {
    let name: String?
}

class UserBusinessModel: BaseBusinessModel, Equatable {
    
    var name: String?
    
    override init() { super.init() }
    
    init(name: String) {
        super.init()
        self.name = name
    }
    required init(serverModel: BaseServerModel?) {
        super.init(serverModel: serverModel)
        guard let serverModel = serverModel as? UserServerModel else {
            return
        }
        self.name = serverModel.name
    }
    static func == (lhs: UserBusinessModel, rhs: UserBusinessModel) -> Bool {
        lhs.name == rhs.name
    }
}

class BaseInteractorTests: XCTestCase {
    var interactor: BaseInteractor!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        interactor = BaseInteractor()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        interactor = nil
    }
    
    func testEncodeViewModelError() {
        let user: UserServerModel? = nil
        let users: [UserServerModel]? = nil
        XCTAssertNoThrow(BaseInteractor.parseToBusinessModel(parserModel: UserBusinessModel.self, serverModel: user))
        
        XCTAssertNoThrow(BaseInteractor.parseArrayToBusinessModel(parserModel: [UserBusinessModel].self, arrayServerModels: users))
    }
    
    func testEncodeBusinessModel() {
        let user = UserServerModel(name: "Jose")
        let userBusinessModel = UserBusinessModel(name: "Jose")
        let model = BaseInteractor.parseToBusinessModel(parserModel: UserBusinessModel.self, serverModel: user)
    
        XCTAssertEqual(model, userBusinessModel)
    }
    
    func testEncodeArrayServerModel() throws {
        let users = [UserServerModel(name: "Maria"),
                     UserServerModel(name: "Pedro"),
                     UserServerModel(name: "Andrea")]
        let usersBusinessModel = [UserBusinessModel(name: "Maria"), UserBusinessModel(name: "Pedro"), UserBusinessModel(name: "Andrea")]
        let model = BaseInteractor.parseArrayToBusinessModel(parserModel: [UserBusinessModel].self, arrayServerModels: users)
      
        XCTAssertEqual(model, usersBusinessModel)
    }
}
