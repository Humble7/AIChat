//
//  ApplicationUtilities.swift
//  AIChat
//
//  Created by ChenZhen on 9/5/25.
//

import Foundation
import SwiftUI
import UIKit

@MainActor
final class ApplicationUtilities {

    static let shared = ApplicationUtilities()
    private init() {}

    var topViewController: UIViewController? {
        guard let scene = UIApplication.shared.connectedScenes
                    .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
                  let root = scene.keyWindow?.rootViewController else {
                return nil
            }
            return Self._topViewController(from: root)
        }

        private static func _topViewController(from viewController: UIViewController) -> UIViewController {
            if let nav = viewController as? UINavigationController {
                return _topViewController(from: nav.visibleViewController ?? nav)
            } else if let tab = viewController as? UITabBarController {
                return _topViewController(from: tab.selectedViewController ?? tab)
            } else if let presented = viewController.presentedViewController {
                return _topViewController(from: presented)
            } else {
                return viewController
            }
        }
}
