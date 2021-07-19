//
//  AppDelegate.swift
//  SNMusic
//
//  Created by Darcy on 2021/6/2.
//

import UIKit
import YiCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate, URLProviderProtocol {

    func baseUrl() -> String {
        return "https://imovie.seungyu.cn"
    }
    
    func setBaseURL(url: String) {
        
    }

    var window: UIWindow? = nil
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        SNTheme.default.apply(theme: .yi)
        
        UILabel.appearance(whenContainedInInstancesOf: [])
        
        let apiSession = ApiSession(baseUrlAdapter: self)
        ApiClient.shared.useSession(session: apiSession)
        
        let nav = SNNavigationController(rootViewController:  SNMusicViewController())
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()

        return true
    }
    
}

