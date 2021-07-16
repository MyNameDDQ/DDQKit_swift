//
//  DDQTextLayoutView.swift
//  Stock_Swift
//
//  Created by MyNameDDQ on 2020/12/16.
//

import UIKit

// 适用于双文字展示
open class DDQTextLayoutView: DDQBasalLayoutView {
    
    open var titleLabel: UILabel = .ddqLabel()
    open var subTitleLabel: UILabel = .ddqLabel()
    
    convenience init(title: String?, subTitle: String?) {
        
        self.init(frame: CGRect.zero)
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
    }
        
    open override func ddqViewInitialize() {
        
        super.ddqViewInitialize()
        self.ddqAddSubViews(subViews: [self.titleLabel, self.subTitleLabel])
        
        self.mainView = self.titleLabel
        self.subView = self.subTitleLabel
    }
}
