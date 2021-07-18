//
//  DDQBasalLayoutView.swift
//  Stock_Swift
//
//  Created by MyNameDDQ on 2020/12/7.
//

import UIKit

open class DDQBasalLayoutView: DDQView {
    public enum DDQBasalLayoutAlignment: Int {
        
        case center = 1
        case left
        case top
        case right
        case bottom
        case leftTop
        case rightTop
        case leftBottom
        case rightBottom
    }
    
    public enum DDQBasalLayoutDirection: Int {
            
        case upperAndLower = 1
        case leftAndRight
    }

    open var mainView: UIView? {
        willSet {
            self.mainView?.removeFromSuperview()
        }
        
        didSet {
            if self.mainView != nil {
                self.addSubview(self.mainView!)
            }
        }
    }
    
    open var subView: UIView? {
        willSet {
            self.subView?.removeFromSuperview()
        }
        
        didSet {
            if self.subView != nil {
                self.addSubview(self.subView!)
            }
        }
    }
    
    open var backgroundView: UIView? {
        willSet {
            self.backgroundView?.removeFromSuperview()
        }
        
        didSet {
            if self.backgroundView != nil {
                self.insertSubview(self.backgroundView!, at: 0)
            }
        }
    }
    
    open var alignment: DDQBasalLayoutAlignment = .center {
        didSet {
            self.ddqSetNeedsLayout()
        }
    }
    
    open var direction: DDQBasalLayoutDirection = .leftAndRight {
        didSet {
            self.ddqSetNeedsLayout()
        }
    }

    // 主视图的布局边界
    open var insets: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            self.ddqSetNeedsLayout()
        }
    }
    
    // 副视图的布局边界
    open var spacings: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            self.ddqSetNeedsLayout()
        }
    }
        
    public convenience init(mainView: UIView, subView: UIView) {
        
        self.init()
        self.mainView = mainView
        if self.mainView != nil {
            self.addSubview(self.mainView!)
        }
        
        self.subView = subView
        if self.subView != nil {
            self.addSubview(self.subView!)
        }
    }
    
    open override func ddqViewInitialize() {
        
        super.ddqViewInitialize()
        
        if let background = self.backgroundView {
            self.addSubview(background)
        }
    }
    
    open override func sizeToFit() {
        
        super.sizeToFit()
        self.isSizeToFit = true
        let fitSize = self.sizeThatFits(.init(width: 10000.0, height: 10000.0))
        self.frame = .init(origin: .zero, size: fitSize)
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
    
        super.sizeThatFits(size)
        self.ddqLayoutSubviews(size: size)
        return self.sizeToFitFrame.size
    }
    
    open override func ddqLayoutSubviewsWhenSetFrame() -> Bool {
        return true
    }
    
    private var sizeToFitFrame: CGRect = .zero
    private var isSizeToFit: Bool = false
    
    open override func ddqLayoutSubviews(size: CGSize) {
        
        super.ddqLayoutSubviews(size: size)
        
        self.backgroundView?.frame = .init(origin: .zero, size: size)
        
        let mainV = self.mainView ?? .init()
        let subV = self.subView ?? .init()
        let _insets = self.insets
        let _spacings = self.spacings
        
        let _alignment = self.alignment
        let _direction = self.direction
        
        mainV.sizeToFit()
        mainV.ddqSetOrigin(origin: .zero)
        
        subV.sizeToFit()
        subV.ddqSetOrigin(origin: .zero)
        
        let maxH = max(subV.ddqHeight, mainV.ddqHeight)
        let maxW = max(subV.ddqWidth, mainV.ddqWidth)

        if self.isSizeToFit {
            
            var rect: CGRect = .zero
            if _direction == .leftAndRight {
                
                mainV.ddqMake { (make) in
                    make.ddqLeft(property: self.ddqMakeLeft, value: _insets.left).ddqCenterY(property: self.ddqMakeCenterY, value: _insets.top).ddqUpdate()
                }

                subV.ddqMake { (make) in
                    make.ddqLeft(property: mainV.ddqMakeRight, value: _spacings.left).ddqCenterY(property: mainV.ddqMakeCenterY, value: 0.0).ddqUpdate()
                }
                
                rect = .init(origin: .zero, size: .init(width: subV.ddqMaxX + self.insets.right, height: self.insets.top + self.insets.bottom + max(mainV.ddqHeight, subV.ddqHeight)))
            } else {
                
                mainV.ddqMake { (make) in
                    make.ddqCenterX(property: self.ddqMakeCenterX, value: _insets.left).ddqTop(property: self.ddqMakeTop, value: _insets.top).ddqUpdate()
                }
                
                subV.ddqMake { (make) in
                    make.ddqCenterX(property: mainV.ddqMakeCenterX, value: _spacings.left).ddqTop(property: mainV.ddqMakeBottom, value: _spacings.top).ddqUpdate()
                }
                
                rect = .init(origin: .zero, size: .init(width: maxW + _insets.left + _insets.right, height: _insets.top + mainV.ddqHeight + _spacings.top + subV.ddqHeight + _insets.bottom))
            }
            
            self.sizeToFitFrame = rect
            
        } else {
            if _direction == .leftAndRight {
                if _alignment == .center {
                    
                    mainV.ddqMake { (make) in
                        make.ddqRight(property: self.ddqMakeCenterX, value: -_spacings.left * 0.5).ddqCenterY(property: self.ddqMakeCenterY, value: _insets.top).ddqUpdate()
                    }
                    
                    subV.ddqMake { (make) in
                        make.ddqLeft(property: mainV.ddqMakeRight, value: _spacings.left).ddqCenterY(property: mainV.ddqMakeCenterY, value: _spacings.top).ddqUpdate()
                    }
                } else if _alignment == .left {
                    
                    mainV.ddqMake { (make) in
                        make.ddqLeft(property: self.ddqMakeLeft, value: _insets.left).ddqCenterY(property: self.ddqMakeCenterY, value: _insets.top).ddqUpdate()
                    }
                    
                    subV.ddqMake { (make) in
                        make.ddqLeft(property: mainV.ddqMakeRight, value: _spacings.left).ddqCenterY(property: mainV.ddqMakeCenterY, value: _spacings.top).ddqUpdate()
                    }
                } else if _alignment == .top {
                    
                    mainV.ddqMake { (make) in
                        make.ddqRight(property: self.ddqMakeCenterX, value: -_spacings.left * 0.5).ddqTop(property: self.ddqMakeTop, value: _insets.top).ddqUpdate()
                    }
                    
                    subV.ddqMake { (make) in
                        make.ddqLeft(property: mainV.ddqMakeRight, value: _spacings.left).ddqCenterY(property: mainV.ddqMakeCenterY, value: _spacings.top).ddqUpdate()
                    }
                } else if _alignment == .bottom {
                    
                    mainV.ddqMake { (make) in
                        make.ddqRight(property: self.ddqMakeCenterX, value: -_spacings.left * 0.5).ddqBottom(property: self.ddqMakeBottom, value: -_insets.bottom).ddqUpdate()
                    }
                    
                    subV.ddqMake { (make) in
                        make.ddqLeft(property: mainV.ddqMakeRight, value: _spacings.left).ddqCenterY(property: mainV.ddqMakeCenterY, value: -_spacings.bottom).ddqUpdate()
                    }
                } else if _alignment == .right {
                    
                    subV.ddqMake { (make) in
                        make.ddqRight(property: self.ddqMakeRight, value: -_insets.right).ddqCenterY(property: self.ddqMakeCenterY, value: _insets.top).ddqUpdate()
                    }
                    
                    mainV.ddqMake { (make) in
                        make.ddqRight(property: subV.ddqMakeLeft, value: -_spacings.right).ddqCenterY(property: subV.ddqMakeCenterY, value: _spacings.top).ddqUpdate()
                    }
                } else if _alignment == .leftTop {
                    
                    mainV.ddqMake { (make) in
                        make.ddqLeft(property: self.ddqMakeLeft, value: _insets.left).ddqCenterY(property: self.ddqMakeTop, value: (maxH * 0.5 + _insets.top)).ddqUpdate()
                    }
                    
                    subV.ddqMake { (make) in
                        make.ddqLeft(property: mainV.ddqMakeRight, value: _spacings.left).ddqCenterY(property: mainV.ddqMakeCenterY, value: _spacings.top).ddqUpdate()
                    }
                } else if _alignment == .leftBottom {
                    
                    mainV.ddqMake { (make) in
                        make.ddqLeft(property: self.ddqMakeLeft, value: _insets.left).ddqCenterY(property: self.ddqMakeBottom, value: -(maxH * 0.5 + _insets.bottom)).ddqUpdate()
                    }
                    
                    subV.ddqMake { (make) in
                        make.ddqLeft(property: mainV.ddqMakeRight, value: _spacings.left).ddqCenterY(property: mainV.ddqMakeCenterY, value: _spacings.top).ddqUpdate()
                    }
                } else if _alignment == .rightTop {
                    
                    subV.ddqMake { (make) in
                        make.ddqRight(property: self.ddqMakeRight, value: -_insets.right).ddqCenterY(property: self.ddqMakeTop, value: (maxH * 0.5 + _insets.top)).ddqUpdate()
                    }
                    
                    mainV.ddqMake { (make) in
                        make.ddqRight(property: subV.ddqMakeLeft, value: -_spacings.right).ddqCenterY(property: subV.ddqMakeCenterY, value: _spacings.top).ddqUpdate()
                    }
                } else {
                    
                    subV.ddqMake { (make) in
                        make.ddqRight(property: self.ddqMakeRight, value: -_insets.right).ddqCenterY(property: self.ddqMakeBottom, value: -(maxH * 0.5 + _insets.bottom)).ddqUpdate()
                    }
                    
                    mainV.ddqMake { (make) in
                        make.ddqRight(property: subV.ddqMakeLeft, value: -_spacings.right).ddqCenterY(property: subV.ddqMakeCenterY, value: -_spacings.bottom).ddqUpdate()
                    }
                }
            } else {
                if _alignment == .center {
                    
                    mainV.ddqMake { (make) in
                        make.ddqCenterX(property: self.ddqMakeCenterX, value: _insets.left).ddqBottom(property: self.ddqMakeCenterY, value: -_spacings.top * 0.5).ddqUpdate()
                    }
                    
                    subV.ddqMake { (make) in
                        make.ddqCenterX(property: mainV.ddqMakeCenterX, value: _spacings.left).ddqTop(property: mainV.ddqMakeBottom, value: _spacings.top).ddqUpdate()
                    }
                } else if _alignment == .left {
                    
                    mainV.ddqMake { (make) in
                        make.ddqCenterX(property: self.ddqMakeLeft, value: (maxW * 0.5 + _insets.left)).ddqBottom(property: self.ddqMakeCenterY, value: -_spacings.top * 0.5).ddqUpdate()
                    }
                    
                    subV.ddqMake { (make) in
                        make.ddqCenterX(property: mainV.ddqMakeCenterX, value: _spacings.left).ddqTop(property: mainV.ddqMakeBottom, value: _spacings.top).ddqUpdate()
                    }
                } else if _alignment == .top {
                    
                    mainV.ddqMake { (make) in
                        make.ddqCenterX(property: self.ddqMakeCenterX, value: _insets.left).ddqTop(property: self.ddqMakeTop, value: _insets.top).ddqUpdate()
                    }
                    
                    subV.ddqMake { (make) in
                        make.ddqCenterX(property: mainV.ddqMakeCenterX, value: _spacings.left).ddqTop(property: mainV.ddqMakeBottom, value: _spacings.top).ddqUpdate()
                    }
                } else if _alignment == .bottom {
                    
                    subV.ddqMake { (make) in
                        make.ddqCenterX(property: self.ddqMakeCenterX, value: _insets.left).ddqBottom(property: self.ddqMakeBottom, value: -_insets.bottom).ddqUpdate()
                    }
                    
                    mainV.ddqMake { (make) in
                        make.ddqCenterX(property: subV.ddqMakeCenterX, value: _spacings.left).ddqBottom(property: subV.ddqMakeTop, value: -spacings.top).ddqUpdate()
                    }
                } else if _alignment == .right {
                    
                    mainV.ddqMake { (make) in
                        make.ddqCenterX(property: self.ddqMakeRight, value: -(maxW * 0.5 + _insets.right)).ddqBottom(property: self.ddqMakeCenterY, value: -_spacings.top).ddqUpdate()
                    }
                    
                    subV.ddqMake { (make) in
                        make.ddqCenterX(property: mainV.ddqMakeCenterX, value: _spacings.left).ddqTop(property: mainV.ddqMakeBottom, value: _spacings.top).ddqUpdate()
                    }
                } else if _alignment == .leftTop {
                    
                    mainV.ddqMake { (make) in
                        make.ddqCenterX(property: self.ddqMakeLeft, value: (maxW * 0.5 + _insets.left)).ddqTop(property: self.ddqMakeTop, value: _insets.top).ddqUpdate()
                    }
                    
                    subV.ddqMake { (make) in
                        make.ddqCenterX(property: mainV.ddqMakeCenterX, value: _spacings.left).ddqTop(property: mainV.ddqMakeBottom, value: _spacings.top).ddqUpdate()
                    }
                } else if _alignment == .leftBottom {
                    
                    subV.ddqMake { (make) in
                        make.ddqCenterX(property: self.ddqMakeLeft, value: (maxW * 0.5 + _insets.left)).ddqBottom(property: self.ddqMakeBottom, value: -_insets.bottom).ddqUpdate()
                    }
                    
                    mainV.ddqMake { (make) in
                        make.ddqCenterX(property: subV.ddqMakeCenterX, value: _spacings.left).ddqBottom(property: subV.ddqMakeTop, value: -_spacings.top).ddqUpdate()
                    }
                } else if _alignment == .rightTop {
                    
                    mainV.ddqMake { (make) in
                        make.ddqCenterX(property: self.ddqMakeRight, value: -(maxW * 0.5 + _insets.right)).ddqTop(property: self.ddqMakeTop, value: _insets.top).ddqUpdate()
                    }
                    
                    subV.ddqMake { (make) in
                        make.ddqCenterX(property: mainV.ddqMakeCenterX, value: _spacings.left).ddqTop(property: mainV.ddqMakeBottom, value: _spacings.top).ddqUpdate()
                    }
                } else {
                    
                    subV.ddqMake { (make) in
                        make.ddqCenterX(property: self.ddqMakeRight, value: -(maxW * 0.5 + _insets.right)).ddqBottom(property: self.ddqMakeBottom, value: -_insets.bottom).ddqUpdate()
                    }
                    
                    mainV.ddqMake { (make) in
                        make.ddqCenterX(property: subV.ddqMakeCenterX, value: _spacings.left).ddqBottom(property: subV.ddqMakeTop, value: -_spacings.top).ddqUpdate()
                    }
                }
            }
        }
    }
}
