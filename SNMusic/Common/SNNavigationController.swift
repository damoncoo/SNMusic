//
//  SNNavigationController.swift
//  SNMusic
//
//  Created by Darcy on 2021/7/12.
//

import UIKit
import YiCore

class SNNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .pageBgColor
        
        self.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = UIColor.themeColor
        self.navigationBar.tintColor = UIColor.white
        
        let font =  UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        let color = UIColor.white

        self.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color,
        ]
        self.navigationBar.shadowImage = UIImage()
        self.interactivePopGestureRecognizer?.delegate = self
        
        if #available(iOS 15.0, *) {
            
            let app = UINavigationBarAppearance.init()
            app.configureWithOpaqueBackground()  // 重置背景和阴影颜色
            app.titleTextAttributes = [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: color,
            ]            
            app.backgroundColor = UIColor.themeColor  // 设置导航栏背景色
            app.shadowImage = UIImage() // 设置导航栏下边界分割线透明
            navigationBar.scrollEdgeAppearance = app  // 带scroll滑动的页面
            navigationBar.standardAppearance = app // 常规页面
        }
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {

        return true
    }
    
    override var childForStatusBarStyle: UIViewController? {
        
        return self.topViewController
    }
    
}
