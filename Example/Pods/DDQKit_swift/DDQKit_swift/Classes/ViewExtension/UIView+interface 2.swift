//
//  UIView+interface.swift
//  BQRealtor
//
//  Created by MyNameDDQ on 2021/5/8.
//

import UIKit

public var ddqScreenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

public var ddqScreenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

public var ddqKeyWindow: UIWindow? {
    return UIApplication.shared.keyWindow
}

public var ddqRootViewController: UIViewController? {
    return ddqKeyWindow?.rootViewController
}

@available(iOS 13.0, *)
public var ddqUserInterfaceStyle: UIUserInterfaceStyle {
    return UITraitCollection.current.userInterfaceStyle
}

public var ddqIsLightStyle: Bool {
    if #available(iOS 13.0, *) {
        return UITraitCollection.current.ddqIsLightStyle
    }
    
    return true
}

extension UITraitCollection {
    @available(iOS 13.0, *)
    var ddqIsLightStyle: Bool {
        return self.userInterfaceStyle != .dark
    }
}

public extension UIView {    
    var ddqX: CGFloat {
        return self.frame.minX
    }
    
    var ddqY: CGFloat {
        return self.frame.minY
    }

    var ddqWidth: CGFloat {
        return self.bounds.width
    }
    
    var ddqHeight: CGFloat {
        return self.bounds.height
    }

    var ddqMaxY: CGFloat {
        return self.frame.maxY
    }
    
    var ddqMaxX: CGFloat {
        return self.frame.maxX
    }
    
    var ddqMidY: CGFloat {
        return self.frame.midY
    }
    
    var ddqMidX: CGFloat {
        return self.frame.midX
    }
    
    var ddqBoundsMaxY: CGFloat {
        return self.bounds.maxY
    }
    
    var ddqBoundsMaxX: CGFloat {
        return self.bounds.maxX
    }
    
    var ddqBoundsMidY: CGFloat {
        return self.bounds.midY
    }
    
    var ddqBoundsMidX: CGFloat {
        return self.bounds.midX
    }
    
    var ddqSize: CGSize {
        return self.bounds.size
    }
    
    func ddqSetOrigin(origin: CGPoint) {
        
        var frame = self.frame
        frame.origin = origin
        self.frame = frame
    }
    
    func ddqSetX(x: CGFloat) {
        self.ddqSetOrigin(origin: CGPoint(x: x, y: self.ddqY))
    }
    
    func ddqSetY(y: CGFloat) {
        self.ddqSetOrigin(origin: CGPoint(x: self.ddqX, y: y))
    }
    
    func ddqSetSize(size: CGSize) {
        
        var frame = self.frame
        frame.size = size
        self.frame = frame
    }
    
    func ddqSetWidth(width: CGFloat) {
        self.ddqSetSize(size: CGSize(width: width, height: self.ddqHeight))
    }
    
    func ddqSetHeight(height: CGFloat) {
        self.ddqSetSize(size: CGSize(width: self.ddqWidth, height: height))
    }
    
    func ddqSetLayerCornerRadius(v: CGFloat) {
        self.ddqSetLayer(radius: v, width: nil, color: nil)
    }
    
    func ddqSetLayerBorderWidth(v: CGFloat) {
        self.ddqSetLayer(radius: nil, width: v, color: nil)
    }
    
    func ddqSetLayerBorderColor(c: UIColor) {
        self.ddqSetLayer(radius: nil, width: nil, color: c)
    }
    
    func ddqSetLayer(radius: CGFloat?, width: CGFloat?, color: UIColor?) {
        if let r = radius {
            self.layer.cornerRadius = r
        }
        
        if let w = width {
            self.layer.borderWidth = w
        }
        
        if let c = color {
            self.layer.borderColor = c.cgColor
        }
    }
        
    var ddqLayoutSafeInsets: UIEdgeInsets {
       
        var insets = UIEdgeInsets()
        let keyWindow = UIApplication.shared.keyWindow
        if #available(iOS 11.0, *) {
            insets = self.safeAreaInsets
        } else {
            
            insets.top = keyWindow?.rootViewController?.topLayoutGuide.length ?? 0.0
            insets.bottom = keyWindow?.rootViewController?.bottomLayoutGuide.length ?? 0.0
        }
        
        return insets
    }
}
