//
//  DDQAutoLayoutProperty.swift
//  Stock_Swift
//
//  Created by MyNameDDQ on 2020/12/30.
//

import UIKit

open class DDQAutoLayoutProperty: NSObject {
    public enum DDQAutoLayoutAligment: Int {
        
        case left
        case right
        case top
        case bottom
        case centerX
        case centerY
        case center
    }
    
    open var aligment: DDQAutoLayoutAligment = .left
    open var layoutView: UIView?
    
    public convenience init(view: UIView, aligment: DDQAutoLayoutAligment) {
        
        self.init()
        self.layoutView = view
        self.aligment = aligment
    }
}

public extension UIView {
    var ddqMakeLeft: DDQAutoLayoutProperty {
        return DDQAutoLayoutProperty(view: self, aligment: .left)
    }
    
    var ddqMakeRight: DDQAutoLayoutProperty {
        return DDQAutoLayoutProperty(view: self, aligment: .right)
    }
    
    var ddqMakeTop: DDQAutoLayoutProperty {
        return DDQAutoLayoutProperty(view: self, aligment: .top)
    }
    
    var ddqMakeBottom: DDQAutoLayoutProperty {
        return DDQAutoLayoutProperty(view: self, aligment: .bottom)
    }
    
    var ddqMakeCenterX: DDQAutoLayoutProperty {
        return DDQAutoLayoutProperty(view: self, aligment: .centerX)
    }
    
    var ddqMakeCenterY: DDQAutoLayoutProperty {
        return DDQAutoLayoutProperty(view: self, aligment: .centerY)
    }
    
    var ddqMakeCenter: DDQAutoLayoutProperty {
        return DDQAutoLayoutProperty(view: self, aligment: .center)
    }
}
