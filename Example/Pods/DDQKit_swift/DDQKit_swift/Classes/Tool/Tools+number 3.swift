//
//  Tools+number.swift
//  BQRealtor
//
//  Created by MyNameDDQ on 2021/6/23.
//

import Foundation
import UIKit

extension Int {
    func ddqToCGFloat() -> CGFloat {
        return CGFloat(self)
    }
    
    func ddqToDouble() -> Double {
        return Double(self)
    }
    
    func ddqToFloat() -> Float {
        return Float(self)
    }
    
    func ddqToString() -> String {
        return String(format: "%d", self)
    }
    
    func ddqToScaleValue() -> CGFloat {
        return Double(self).ddqToCGFloat().ddqScaleValue()
    }
    
    func ddqToScaleValue(scale: CGFloat) -> CGFloat {
        return Double(self).ddqToCGFloat().ddqScaleValue(scale: scale)
    }
    
    /// 人民币：分 -> 元
    func ddqToYuan() -> Double {
        return self.ddqToDouble() / 100.0
    }
    
    func ddqToDateString(formatter: String?) -> String {
        
        let date = Date(timeIntervalSince1970: self.ddqToDouble())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter ?? "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: date)
    }
}

extension Double {
    func ddqToCGFloat() -> CGFloat {
        return CGFloat(self)
    }
    
    func ddqToInt() -> Int {
        return Int(self)
    }
    
    func ddqToFloat() -> Float {
        return Float(self)
    }
    
    func ddqToString() -> String {
        return String(format: "%f", self)
    }
    
    func ddqToScaleValue() -> CGFloat {
        return ddqToCGFloat().ddqScaleValue()
    }
    
    func ddqToScaleValue(scale: CGFloat) -> CGFloat {
        return ddqToCGFloat().ddqScaleValue(scale: scale)
    }
}

extension Float {
    func ddqToCGFloat() -> CGFloat {
        return CGFloat(self)
    }
    
    func ddqToInt() -> Int {
        return Int(self)
    }
    
    func ddqToDouble() -> Double {
        return Double(self)
    }
    
    func ddqToString() -> String {
        return String(format: "%f", self)
    }
    
    func ddqToScaleValue() -> CGFloat {
        return ddqToCGFloat().ddqScaleValue()
    }
    
    func ddqToScaleValue(scale: CGFloat) -> CGFloat {
        return ddqToCGFloat().ddqScaleValue(scale: scale)
    }
}

extension CGFloat {
    func ddqToDouble() -> Double {
        return Double(self)
    }
    
    func ddqToInt() -> Int {
        return Int(self)
    }
    
    func ddqToFloat() -> Float {
        return Float(self)
    }
    
    func ddqToString() -> String {
        return String(format: "%f", self)
    }
}

extension String {
    func ddqToInt() -> Int {
        
        let nsstring = self as NSString
        return nsstring.integerValue
    }
    
    func ddqToDouble() -> Double {
        
        let nsstring = self as NSString
        return nsstring.doubleValue
    }
    
    func ddqToFloat() -> Float {
        
        let nsstring = self as NSString
        return nsstring.floatValue
    }

    func ddqToBool() -> Bool {
        
        let nsstring = self as NSString
        return nsstring.boolValue
    }
    
    func ddqToCGFloat() -> CGFloat {
        
        let nsstring = self as NSString
        return nsstring.doubleValue.ddqToCGFloat()
    }
}
