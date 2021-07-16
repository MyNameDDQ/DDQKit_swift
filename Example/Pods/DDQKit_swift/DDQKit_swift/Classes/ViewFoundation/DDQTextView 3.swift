//
//  DDQTextView.swift
//  BQRealtor
//
//  Created by MyNameDDQ on 2021/4/6.
//

import UIKit

open class DDQTextView: UITextView, UITextViewDelegate {
    
    private var _placeholderLabel: UILabel = .ddqLabel(text: nil, font: nil, textColor: .ddqPlaceholderColor())
    
    open var placeholder: String? {
        didSet {
            self._placeholderLabel.text = self.placeholder
        }
    }
    
    open var attributedPlaceholder: NSAttributedString? {
        didSet {
            self._placeholderLabel.attributedText = self.attributedPlaceholder
        }
    }
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        
        super.init(frame: frame, textContainer: textContainer)
        self._handlePlaceholderLabel()
    }
    
    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        self._handlePlaceholderLabel()
    }
    
    open override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self._placeholderLabel.sizeToFit()
        let width = self._placeholderLabel.width
        self._placeholderLabel.frame = .init(x: self.ddqBeginningRect.minX, y: self.ddqBeginningRect.minY, width: width, height: self.ddqBeginningRect.height)
    }
        
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self._placeholderLabel.isHidden = true
        }
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        if !textView.text.isEmpty {
            self._placeholderLabel.isHidden = true
        } else {
            self._placeholderLabel.isHidden = false
        }
    }
    
    private func _handlePlaceholderLabel() {
        
        self.delegate = self
        self.ddqAddSubViews(subViews: [self._placeholderLabel])
        _ = self._placeholderLabel.ddqAddTapGestureRecognizer { (_) in            
            self.becomeFirstResponder()
        }        
    }
}
