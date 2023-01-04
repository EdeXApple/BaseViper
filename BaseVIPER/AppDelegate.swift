//
//  AppDelegate.swift
//  testSPM
//
//  Created by EDEX on 29/3/22.
//

import MCVIPER
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if window != nil {
            BaseRouter.setRoot(navigationController: HomeAssembly.navigationController())
        }
        return true
    }
}
