//
//  UIColor+color.swift
//  BQRealtor
//
//  Created by MyNameDDQ on 2021/5/22.
//

import UIKit

/// init
public extension UIColor {
    class func ddqColorWithRGBAC(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat, component: CGFloat) -> UIColor {
        return UIColor.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha).withAlphaComponent(component)
    }

    class func ddqColorWithRGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return ddqColorWithRGBAC(red: red, green: green, blue: blue, alpha: 1.0, component: 1.0)
    }

    class func ddqColorWithRGBA(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return ddqColorWithRGBAC(red: red, green: green, blue: blue, alpha: alpha, component: 1.0)
    }

    class func ddqColorWithRGBC(red: CGFloat, green: CGFloat, blue: CGFloat, component: CGFloat) -> UIColor {
        return ddqColorWithRGBAC(red: red, green: green, blue: blue, alpha: 1.0, component: component)
    }

    class func ddqColorWithHexAC(hexString: String?, alpha: CGFloat, component: CGFloat) -> UIColor {
        guard hexString != nil else {
            return clear
        }
        
        let colorString = hexString!.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: colorString)
        if colorString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        return ddqColorWithRGBAC(red: red, green: green, blue: blue, alpha: alpha, component: component)
    }

    class func ddqColorWithHexA(hexString: String?, alpha: CGFloat) -> UIColor {
        return ddqColorWithHexAC(hexString: hexString, alpha: alpha, component: 1.0)
    }

    class func ddqColorWithHexC(hexString: String?, component: CGFloat) -> UIColor {
        return ddqColorWithHexAC(hexString: hexString, alpha: 1.0, component: component)
    }

    class func ddqColorWithHex(hexString: String?) -> UIColor {
        return ddqColorWithHexAC(hexString: hexString, alpha: 1.0, component: 1.0)
    }

    func ddqColorToHexString() -> String? {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        let multiplier = CGFloat(255.999999)
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
                 
        if alpha == 1.0 {
            return String(format: "#%02lX%02lX%02lX", Int(red * multiplier), Int(green * multiplier), Int(blue * multiplier))
        } else {
            return String(format: "#%02lX%02lX%02lX%02lX", Int(red * multiplier), Int(green * multiplier), Int(blue * multiplier), Int(alpha * multiplier))
        }
    }
}

/// 自定义一些常用的颜色
public extension UIColor {
    class func ddqTextColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (collection) -> UIColor in
                return collection.ddqIsLightStyle ? ddqColorWithRGB(red: 53.0, green: 53.0, blue: 53.0) : white
            }
        }

        return ddqColorWithRGB(red: 53.0, green: 53.0, blue: 53.0)
    }
        
    class func ddqBackgroundColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (collection) -> UIColor in
                return collection.ddqIsLightStyle ? white : black
            }
        }
        
        return white
    }
            
    class func ddqSeparatorColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (collection) -> UIColor in
                return collection.ddqIsLightStyle ? ddqColorWithRGB(red: 205.0, green: 205.0, blue: 205.0) : white
            }
        }

        return ddqColorWithRGB(red: 153.0, green: 153.0, blue: 153.0)
    }
        
    class func ddqPlaceholderColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (collection) -> UIColor in
                return collection.ddqIsLightStyle ? UIColor.lightGray.withAlphaComponent(0.7) : white
            }
        }

        return UIColor.lightGray.withAlphaComponent(0.7)
    }
}
