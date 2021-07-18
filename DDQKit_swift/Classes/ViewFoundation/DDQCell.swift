//
//  DDQCell.swift
//  Stock_Swift
//
//  Created by MyNameDDQ on 2020/12/16.
//

import UIKit

open class DDQCellModel: DDQModel {

    var ddqReuseHeight: CGFloat = 0.0
    var ddqCellWidth: CGFloat = 0.0
}

public struct DDQCellSeparatorMargin {
    
    var leftMargin: CGFloat
    var rightMargin: CGFloat
}

public extension DDQCellSeparatorMargin {
    static public var Zero: DDQCellSeparatorMargin {
        return DDQCellSeparatorMargin(leftMargin: 0.0, rightMargin: 0.0)
    }
}

public enum DDQCellSeparatorStyle {
    
    case none
    case top
    case bottom
}

open class DDQCell: UITableViewCell {

    private var ddqSeparator: UIView = UIView(frame: CGRect.zero)
    
    open var ddqCellDataSource: DDQCellModel? {
        didSet {
            
            self.ddqCellDidUpdateData()
            self.ddqCellLayoutSubviews(size: self.contentView.ddqSize)
            self.ddqCellSetNeedsLayout()
        }
    }
    
    open var ddqSeparatorStyle: DDQCellSeparatorStyle = DDQCellSeparatorStyle.none {
        didSet {
            self.ddqCellSetNeedsLayout()
        }
    }
    
    open var ddqSeparatorMargin: DDQCellSeparatorMargin = DDQCellSeparatorMargin.Zero {
        didSet {            
            self.ddqCellSetNeedsLayout()
        }
    }
    
    open var ddqSeparatorColor: UIColor = UIColor.ddqSeparatorColor() {
        didSet {
            self.ddqSeparator.backgroundColor = self.ddqSeparatorColor
        }
    }
    
    open var ddqSeparatorHeight: CGFloat = 0.5 {
        didSet {
            self.ddqCellSetNeedsLayout()
        }
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
    
    private(set) open var ddqIsLayoutSubviews: Bool = false
    private(set) open var ddqIsInitialize: Bool = false
    open func ddqCellLayoutSubviewsWhenSetFrame() -> Bool {
        return false
    }
    
    open func ddqCellInitialize() {
        
        self.ddqIsInitialize = true
        self.contentView.addSubview(self.ddqSeparator)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        
        self.ddqSeparator.backgroundColor = self.ddqSeparatorColor
        self.contentView.backgroundColor = .ddqBackgroundColor()
    }
    
    open func ddqCellLayoutSubviews(size: CGSize) {
        self.ddqIsLayoutSubviews = true
    }
        
    open func ddqCellSetNeedsLayout() {
        if self.ddqIsLayoutSubviews {
            self.setNeedsLayout()
        }
    }
    
    open func ddqCellDidUpdateData() {}
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.ddqCellInitialize()
        self.ddqHandlePendingSubviews()
    }
    
    required public init?(coder: NSCoder) {
        
        super.init(coder: coder)
        self.ddqCellInitialize()
        self.ddqHandlePendingSubviews()
    }
    
    open override var frame: CGRect {
        didSet {
            if self.ddqCellLayoutSubviewsWhenSetFrame() {
                self.ddqCellLayoutSubviews(size: frame.size)
            }
        }
    }
    
    open override func awakeFromNib() {
        
        super.awakeFromNib()
        self.ddqCellInitialize()
        self.ddqHandlePendingSubviews()
    }
    
    open override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    open override func layoutSubviews() {
        
        super.layoutSubviews()
                
        let width = self.contentView.ddqWidth - self.ddqSeparatorMargin.leftMargin - self.ddqSeparatorMargin.rightMargin
        var frame: CGRect = .init(x: self.ddqSeparatorMargin.leftMargin, y: 0.0, width: width, height: self.ddqSeparatorHeight)
        switch self.ddqSeparatorStyle {
        case .none:
            frame = CGRect.zero
            
        case .bottom:
            frame.origin.y = self.contentView.ddqHeight - self.ddqSeparatorHeight
            
        case .top:
            frame.origin.y = 0.0
        }
        
        self.ddqSeparator.frame = frame
        self.ddqCellLayoutSubviews(size: self.contentView.ddqSize)
    }
}
