//
//  LoginInteractorTests.swift
//  BaseVIPERSampleTests
//
//  Created by EdexApple on 12/5/22.
//
@testable import BaseVIPERSample
import Foundation
import MCVIPER
import XCTest

class LoginInteractorTests: XCTestCase {

//    private var provider: LoginProviderMock?
//    private var loginServerModel: LoginServerModel?
//    private var error: BaseErrorModel?
    
//    func testLoginDone() {
//
//        let view = LoginViewController(nibName: "LoginViewController", bundle: nil)
//        let viper = BaseAssembly.assembly(baseView: view,
//                                          presenter: LoginPresenter.self,
//                                          router: LoginRouter.self,
//                                          interactor: LoginInteractor.self)
//
//        viper.interactor.provider = DataAssembly.provider(providerType: LoginProviderMock.self,
//                                                          protocolType: LoginProviderProtocol.self,
//                                                          interactor: viper.interactor)
//        viper.interactor.provider?.login(request: LoginProviderRequest(params: LoginProviderRequest.Params(username: "jromerdu", password: "123456"), headers: nil), completion: { result in
//            switch result {
//            case.success(let serverModel):
//                self.loginServerModel = serverModel
//
//            case .failure(_):
//                break
//            }
//        })
//
//        XCTAssertNotNil(BaseInteractor.parseToBusinessModel(parserModel: LoginBusinessModel.self, serverModel: loginServerModel))
//        XCTAssertTrue(!(self.loginServerModel?.userToken?.isEmpty ?? false))
//        XCTAssertTrue(!(self.loginServerModel?.nickname?.isEmpty ?? false))
//    }
//
//    func testLoginFail() {
//        let view = LoginViewController(nibName: "LoginViewController", bundle: nil)
//        let viper = BaseAssembly.assembly(baseView: view,
//                                          presenter: LoginPresenter.self,
//                                          router: LoginRouter.self,
//                                          interactor: LoginInteractor.self)
//
//        viper.interactor.provider = DataAssembly.provider(providerType: LoginProviderMock.self,
//                                                          protocolType: LoginProviderProtocol.self,
//                                                          interactor: viper.interactor)
//        viper.interactor.provider?.login(request: LoginProviderRequest(params: LoginProviderRequest.Params(username: "", password: ""),
//                                                                       headers: nil),
//                                         completion: { result in
//            switch result {
//            case.success(_):
//                break
//
//            case .failure(let error):
//                self.error = error
//            }
//        })
//
//        XCTAssertNotNil(error)
//        XCTAssertTrue(error?.backendError.type == .userNotFound)
//    }
}
