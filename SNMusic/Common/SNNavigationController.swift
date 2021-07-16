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
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {

        return true
    }
    
    override var childForStatusBarStyle: UIViewController? {
        
        return self.topViewController
    }
    
}
