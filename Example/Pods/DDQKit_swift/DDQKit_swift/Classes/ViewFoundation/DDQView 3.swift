//
//  DDQView.swift
//  Stock_Swift
//
//  Created by MyNameDDQ on 2020/12/7.
//

import UIKit

open class DDQView: UIView {
    
    private(set) open var ddqIsInitialize: Bool = false
    private(set) open var ddqIsLayoutSubviews: Bool = false
    private(set) open var ddqIsSelected: Bool = false
    open var ddqTarget: AnyObject?
    open var ddqAction: Selector?
        
    open func ddqLayoutSubviewsWhenSetFrame() -> Bool {
        return false
    }
    
    open func ddqViewInitialize() {
        
        self.ddqIsInitialize = true
        self.backgroundColor = .ddqBackgroundColor()
    }
    
    open func ddqLayoutSubviews(size: CGSize) {
        self.ddqIsLayoutSubviews = true
    }
    
    open func ddqSetNeedsLayout() {
        if self.ddqIsLayoutSubviews {
            self.setNeedsLayout()
        }
    }
        
    open func ddqAddTargetAction(action: Selector, target: AnyObject) {
        
        self.ddqTarget = target
        self.ddqAction = action
    }
    
    open func ddqRemoveTargetAction() {
        
        self.ddqTarget = nil
        self.ddqAction = nil
    }
    
    open func ddqHandlePendingSubviews() {
        if !self.ddqPendingSubviews().isEmpty {
            
            self.ddqPendingSubviews().ddqForEach { (view, _) in
                view.backgroundColor = .clear
            }
        }
    }
    
    open func ddqPendingSubviews() -> [UIView] {
        return []
    }
        
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.ddqViewInitialize()
        self.ddqHandlePendingSubviews()
    }
    
    required public init?(coder: NSCoder) {
    
        super.init(coder: coder)
        self.ddqViewInitialize()
        self.ddqHandlePendingSubviews()
    }
    
    open override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    open override func layoutSubviews() {
        
        super.layoutSubviews()
        self.ddqLayoutSubviews(size: self.ddqSize)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesEnded(touches, with: event)
        self.ddqIsSelected = !self.ddqIsSelected
        guard self.ddqTarget != nil && self.ddqAction != nil else {
            return
        }
        
        self.ddqTarget!.performSelector(onMainThread: self.ddqAction!, with: self, waitUntilDone: true)
    }
        
    open override var frame: CGRect {
        didSet {
            if self.self.ddqLayoutSubviewsWhenSetFrame() {
                self.ddqLayoutSubviews(size: frame.size)
            }
        }
    }
}
