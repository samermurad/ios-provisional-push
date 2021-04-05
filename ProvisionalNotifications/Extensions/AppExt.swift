//
//  AppExt.swift
//  ProvisionalNotifications
//
//  Created by Samer Murad on 04.04.21.
//

import UIKit

extension UIApplication {
    /// Convenience method to get current topViewController
    /// Cuation: UIApplication.shared.keyWindow is deprecated since iOS 13
    /// But this is irrelevant for us in our scenario because we do not implement multiple windows
    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }

        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController

            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return topViewController(top)
            } else if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }

        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }

        return base
    }
    
    /// Convenience Method to get AppDelegate from static UIApplication Object
    class func AppDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}

