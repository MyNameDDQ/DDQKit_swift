//
//  DDQItem.swift
//  Stock_Swift
//
//  Created by MyNameDDQ on 2020/12/16.
//

import UIKit

open class DDQItem: UICollectionViewCell {
        
    private(set) var ddqIsLayoutSubviews: Bool = false
    private(set) var ddqIsInitialize: Bool = false
    open func ddqItemLayoutSubviewsWhenSetFrame() -> Bool {
        return false
    }
    
    open func ddqItemSetNeedLayout() {
        if self.ddqIsLayoutSubviews {
            self.setNeedsLayout()
        }
    }

    open func ddqItemLayoutSubviews(size: CGSize) {
        self.ddqIsLayoutSubviews = true
    }

    open func ddqItemInitialize() {
        
        self.ddqIsInitialize = true
        self.contentView.backgroundColor = .ddqBackgroundColor()
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
        self.ddqItemInitialize()
        self.ddqHandlePendingSubviews()
    }
    
    required public init?(coder: NSCoder) {
        
        super.init(coder: coder)
        self.ddqItemInitialize()
        self.ddqHandlePendingSubviews()
    }
    
    open override var frame: CGRect {
        didSet {
            if self.ddqItemLayoutSubviewsWhenSetFrame() {
                self.ddqItemLayoutSubviews(size: frame.size)
            }
        }
    }
    
    open override func awakeFromNib() {
        
        super.awakeFromNib()
        self.ddqItemInitialize()
        self.ddqHandlePendingSubviews()
    }
    
    open override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    open override func layoutSubviews() {
        
        super.layoutSubviews()
        self.ddqItemLayoutSubviews(size: self.contentView.ddqSize)
    }
}
