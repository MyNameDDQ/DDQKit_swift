//
//  MBProgressHUD+hud.swift
//  Stock_Swift
//
//  Created by MyNameDDQ on 2021/1/13.
//

import MBProgressHUD

extension MBProgressHUD {
   
    static var ddqDefaultShowTimeInterval: TimeInterval {
        return 1.5
    }
    
    typealias DDQHUDCompletionBlock = (_ hud: MBProgressHUD) -> Void
    
    class func ddqShowHUD(info: String?, inView: UIView?, delay: TimeInterval, animated: Bool) {
        
        let view = _handleHUDSuperView(view: inView)
        if view == nil {
            return
        }
        
        let hud = _foundHUDView(view: view!, animated: true)
        hud?.mode = .text
        hud?.label.numberOfLines = 3
        hud?.label.attributedText = NSAttributedString.init(string: info ?? "", attributes: [.font: UIFont.ddqFont(size: 17.0, weight: .black), .foregroundColor: UIColor.white])
        hud?.bezelView.blurEffectStyle = .dark
        hud?.hide(animated: animated, afterDelay: delay)
    }
    
    class func ddqShowHUD(info: String?, inView: UIView?) {
        self.ddqShowHUD(info: info, inView: inView, delay: ddqDefaultShowTimeInterval, animated: true)
    }
    
    class func ddqShowHUD(info: String?) {
        self.ddqShowHUD(info: info, inView: nil)
    }
    
    class func ddqWaitHUD(info: String?, inView: UIView?, completion: DDQHUDCompletionBlock?) -> MBProgressHUD? {
        
        let view = _handleHUDSuperView(view: inView)
        if view == nil {
            return nil
        }

        let hud = _foundHUDView(view: view!, animated: true)
        hud?.label.attributedText = NSAttributedString.init(string: info ?? "请稍候...", attributes: [.font: UIFont.ddqFont(size: 17.0, weight: .black), .foregroundColor: UIColor.white])
        hud?.bezelView.blurEffectStyle = .dark
        hud?.contentColor = .white
        hud?.completionBlock = {
            if completion != nil {
                completion!(hud!)
            }
        }
        
        return hud
    }
    
    private class func _handleHUDSuperView(view: UIView?) -> UIView? {
        
        let view1 = (view ?? ddqRootViewController?.view) ?? ddqKeyWindow
        return view1
    }
    
    private class func _foundHUDView(view: UIView, animated: Bool) -> MBProgressHUD? {
        
        var hud = MBProgressHUD.forView(view)
        if hud == nil {
            hud = MBProgressHUD.showAdded(to: view, animated: animated)
        } else {        
            hud?.show(animated: animated)
        }
        return hud
    }
}
