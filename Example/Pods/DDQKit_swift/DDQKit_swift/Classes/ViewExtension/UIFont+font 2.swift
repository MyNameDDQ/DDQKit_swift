//
//  UIFont+font.swift
//  BQRealtor
//
//  Created by MyNameDDQ on 2021/5/22.
//

import UIKit

public extension UIFont {
    class func ddqFont(size: CGFloat, weight: Weight) -> UIFont {
        return systemFont(ofSize: size, weight: weight)
    }

    class func ddqFont(size: CGFloat) -> UIFont {
        return ddqFont(size: size, weight: .regular)
    }
    
    class func ddqFont() -> UIFont {
        return ddqFont(size: .ddqTitleSize)
    }
}
