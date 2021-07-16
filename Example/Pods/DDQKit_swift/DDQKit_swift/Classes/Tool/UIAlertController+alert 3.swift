//
//  UIAlertController+alert.swift
//  Stock_Swift
//
//  Created by MyNameDDQ on 2021/1/24.
//

import UIKit

extension UIViewController {
    
    // 可以用在添加了textField等操作后
    // 当返回false时不会自动弹出
    typealias DDQAutoAlertReadyBlock = (_ alertController: UIAlertController) -> Bool
    
    func ddqAlert(style: UIAlertController.Style, title: String?, message: String?, actions: [UIAlertAction]?, autoAlert: DDQAutoAlertReadyBlock?) {
        
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: style)
        guard let buttons = actions else {
            
            let defaultAction = UIAlertAction.init(title: "好的", style: .default, handler: nil)
            alert.addAction(defaultAction)
            return
        }
        
        for button in buttons {
            alert.addAction(button)
        }
        
        guard let ready = autoAlert else {
            return
        }
        
        if ready(alert) {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    typealias DDQDefaultAlertConfirmBlock = () -> Void
    typealias DDQDefaultAlertCancelBlock = () -> Void
    
    func ddqAlert(style: UIAlertController.Style, title: String?, message: String?, confirm: DDQDefaultAlertConfirmBlock?, cancel: DDQDefaultAlertCancelBlock?, autoAlert: DDQAutoAlertReadyBlock?) {
        
        var actions: [UIAlertAction] = []
        if confirm != nil {
            
            let confirmAction = UIAlertAction.init(title: "确认", style: .destructive) { (_) in
                confirm!()
            }
            
            actions.ddqAppend(element: confirmAction)
        }
        
        if cancel != nil {
            
            let cancelAction = UIAlertAction.init(title: "取消", style: .default) { (_) in
                cancel!()
            }
            
            actions.ddqAppend(element: cancelAction)
        }
        
        self.ddqAlert(style: style, title: title, message: message, actions: actions, autoAlert: autoAlert)
    }
    
    func ddqAlert(title: String?, message: String?, confirm: DDQDefaultAlertConfirmBlock?, cancel: DDQDefaultAlertCancelBlock?) {
    
        self.ddqAlert(style: .alert, title: title, message: message, confirm: confirm, cancel: cancel) { (_) -> Bool in return true }
    }
}
