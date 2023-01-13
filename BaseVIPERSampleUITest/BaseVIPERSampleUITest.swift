//
//  BaseVIPERSampleUITest.swift
//  BaseVIPERSampleUITest
//
//  Created by EdexApple on 12/5/22.
//

import XCTest

class BaseVIPERSampleUITest: XCTestCase {

    func testRequiredFieldsPopulated() {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        
        let tableView = app.tables["table"]
        tableView.tap()
        if app.textFields["userTextField"].waitForExistence(timeout: 1) {
        let userTextField = app.textFields["userTextField"]
        
            userTextField.tap()
            userTextField.typeText("jromerdu")
        }
        let passwordTextField = app.secureTextFields["passwordTextField"]
        passwordTextField.tap()
        passwordTextField.typeText("123456")
        
        let loginButton = app.buttons["loginButton"]
        loginButton.tap()
       
        let message = app.staticTexts["labelInfo"].firstMatch
        XCTAssertEqual(message.label, "Usuario Logado")
    }
    
    func testRequiredFieldsNoPopulated() {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        
        let tableView = app.tables["table"]
        tableView.tap()
        
        let userTextField = app.textFields["userTextField"]
        
        userTextField.tap()
        userTextField.typeText("jromerdu")
        
        // How to discard keyboard
        let loginButton = app.buttons["loginButton"]
        loginButton.tap()
        let message = app.staticTexts["labelInfo"]
        XCTAssertEqual(message.label, "Hay campos requeridos")
    }
}
