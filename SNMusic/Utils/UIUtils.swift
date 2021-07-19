//
//  UIUtils.swift
//  SNMusic
//
//  Created by Darcy on 2021/7/17.
//

import UIKit
import SwiftEntryKit
import YiCore

enum ToastLevel {
    case error, warning, info
}

class UIUtils {
    
    
    /// Displays bottom pannel with an error message.
    /// - Parameters:
    ///  - message: message to display
    ///  - duration: duration of display in seconds.
    public static func showToast(message: String, duration: TimeInterval = 3.0, level: ToastLevel = .error) {
        
        var attributes = EKAttributes.topFloat
        attributes.displayDuration = duration
        attributes.entryBackground = .color(color: EKColor(UIColor.black))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3), scale: .init(from: 1, to: 0.7, duration: 0.7)))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10, offset: .zero))
        attributes.statusBar = .dark
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        
        let title = EKProperty.LabelContent(text: "", style: .init(font: UIFont.systemFont(ofSize: 12), color: EKColor( UIColor.white)))
        let description = EKProperty.LabelContent(text: message, style: .init(font: UIFont.systemFont(ofSize: 12), color: EKColor( UIColor.white)))
        let simpleMessage = EKSimpleMessage(image: nil, title: title, description: description)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
}
