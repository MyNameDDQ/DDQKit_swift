//
//  UIViewController+handler.swift
//  BQRealtor
//
//  Created by MyNameDDQ on 2021/6/25.
//

import UIKit

public extension UIViewController {
    func ddqPop(to cClass: AnyClass, nib: Bool, animated: Bool) {
        guard let nav = self.navigationController else {
            return
        }
        
        var target: UIViewController?
        for controller in nav.viewControllers {
            if controller.self.isEqual(cClass) {
                
                target = controller
                break
            }
        }
        
        guard let controller = target else {
            return
        }
        
        self.ddqPop(to: controller, animated: animated)
    }
    
    func ddqPop(to index: Int, animated: Bool) {
        guard let nav = self.navigationController else {
            return
        }
        
        if index <= nav.viewControllers.count - 1 {
            self.ddqPop(to: nav.viewControllers[index], animated: animated)
        }
    }

    func ddqPop(to: UIViewController?, animated: Bool) {
        guard let nav = self.navigationController else {
            return
        }
        
        if to != nil {
            nav.popToViewController(to!, animated: animated)
        } else {
            nav.popViewController(animated: animated)
        }
    }
    
    func ddqPop(animated: Bool) {
        self.ddqPop(to: nil, animated: animated)
    }
    
    func ddqPush(to: UIViewController, title: String?, animated: Bool) {
        guard let nav = self.navigationController else {
            return
        }
                    
        to.title = title
        to.hidesBottomBarWhenPushed = true
        nav.pushViewController(to, animated: animated)
    }
    
    func ddqPush(toClass: AnyClass, title: String?, animated: Bool) {
        if toClass.isSubclass(of: UIViewController.self) {
            if let a = toClass as? UIViewController.Type {
                self.ddqPush(to: a.init(), title: title, animated: animated)
            }
        }
    }
}

public extension UIViewController {
    var ddqSafeInsets: UIEdgeInsets {
        if #available(iOS 13.0, *) {
            return self.view.safeAreaInsets
        }
        
        return .init(top: self.topLayoutGuide.length, left: 0.0, bottom: self.bottomLayoutGuide.length, right: 0.0)
    }
}
