//
//  UIView+guideline.swift
//  BQRealtor
//
//  Created by MyNameDDQ on 2021/5/8.
//
//  根据开源设计规范 Backpack所规定
//  https://github.com/jaredpalmer/backpack

import UIKit

/// 定义控件的默认间距。
public extension CGFloat {
    /// 4
    static var ddqSpacingS: CGFloat {
        return 4.0.ddqToScaleValue()
    }
    
    /// 8
    static var ddqSpacingM: CGFloat {
        return 8.0.ddqToScaleValue()
    }
    
    /// 16
    static var ddqSpacingB: CGFloat {// base
        return 16.0.ddqToScaleValue()
    }
    
    /// 24
    static var ddqSpacingL: CGFloat {
        return 24.0.ddqToScaleValue()
    }
    
    /// 32
    static var ddqSpacingXL: CGFloat {
        return 32.0.ddqToScaleValue()
    }
    
    /// 40.0
    static var ddqSpacingXXL: CGFloat {
        return 40.0.ddqToScaleValue()
    }
}

public extension UIEdgeInsets {
    
    /// 布局时的四边边距
    static var ddqEdgeInsets: UIEdgeInsets {
        let value: CGFloat = .ddqSpacingB
        return .init(top: value, left: value, bottom: value, right: value)
    }
    
    /// 布局内的控件间隔
    static var ddqSpacingInsets: UIEdgeInsets {
        let value: CGFloat = .ddqSpacingM
        return .init(top: value, left: value, bottom: value, right: value)
    }
}

public extension CGFloat {
    /// 16
    static var ddqTitleSize: CGFloat {
        return 16.0
    }
    
    /// 20
    static var ddqTitle2Size: CGFloat {
        return 20.0
    }
    
    /// 24
    static var ddqTitle3Size: CGFloat {
        return 24.0
    }

    /// 14
    static var ddqSubTitleSize: CGFloat {
        return 14.0
    }
    
    /// 15
    static var ddqBodySize: CGFloat {
        return 15.0
    }
    
    /// 12
    static var ddqSmallSize: CGFloat {
        return 12.0
    }
        
    /// 36
    static var ddqXLSize: CGFloat {
        return 36.0
    }
    
    /// 42
    static var ddqXXLSize: CGFloat {
        return 42.0
    }
}

extension CGFloat {
    // 默认6s比例
    func ddqScaleValue() -> CGFloat {
        return ddqScaleValue(scale: UIScreen.main.bounds.width / 375.0)
    }
    
    // 布局时的比例
    func ddqScaleValue(scale: CGFloat) -> CGFloat {
        return self * scale
    }
}
