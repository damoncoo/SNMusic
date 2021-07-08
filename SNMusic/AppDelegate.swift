//
//  AppDelegate.swift
//  SNMusic
//
//  Created by Darcy on 2021/6/2.
//

import UIKit
import YiCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = nil
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = ViewController()        
        self.window?.makeKeyAndVisible()
                
        return true
    }
    

}

