//
//  BasePresenterTests.swift
//  
//
//  Created by EdexApple on 23/5/22.
//

import VIPERPLUS
import XCTest

class UserViewModel: BaseViewModel, Equatable {
    
    var name: String?
    
    override init() { super.init() }
    
    init(name: String) {
        super.init()
        self.name = name
    }
    required init(businessModel: BaseBusinessModel?) {
        super.init(businessModel: businessModel)
        guard let businessModel = businessModel as? UserBusinessModel else {
            return
        }
        self.name = businessModel.name
    }
    
    static func == (lhs: UserViewModel, rhs: UserViewModel) -> Bool {
        lhs.name == rhs.name
    }
}

class BasePresenterTests: XCTestCase {
    private var presenter: BasePresenter!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        presenter = BasePresenter()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        presenter = nil
    }
    
    func testEncodeViewModelError() {
        let user: UserBusinessModel? = nil
    
        XCTAssertNoThrow(BasePresenter.parseToViewModel(parserModel: UserViewModel.self, businessModel: user))
        
        let users: [UserBusinessModel]? = nil
        XCTAssertNoThrow(BasePresenter.parseArrayToViewModel(parserModel: [UserViewModel].self, businessModel: users))
    }
    
    func testEncodeViewModel() {
        let user = UserBusinessModel(name: "Jose")
        let userViewModel = UserViewModel(name: "Jose")
        let model = BasePresenter.parseToViewModel(parserModel: UserViewModel.self, businessModel: user)
    
        XCTAssertEqual(model, userViewModel)
    }
    
    func testEncodeArrayServerModel() throws {
        let users = [UserBusinessModel(name: "Maria"),
                     UserBusinessModel(name: "Pedro"),
                     UserBusinessModel(name: "Andrea")]
        let usersViewModel = [UserViewModel(name: "Maria"), UserViewModel(name: "Pedro"), UserViewModel(name: "Andrea")]
        let model = BasePresenter.parseArrayToViewModel(parserModel: [UserViewModel].self, businessModel: users)
      
        XCTAssertEqual(model, usersViewModel)
    }
}
