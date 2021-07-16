//
//  UIView+extension.swift
//  BQRealtor
//
//  Created by MyNameDDQ on 2021/6/2.
//

import UIKit
import YYKit

public extension UILabel {
    class func ddqAttributes() -> [NSAttributedString.Key: Any] {
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 5.0
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .left
        return [.font: UIFont.ddqFont(), .foregroundColor: UIColor.ddqTextColor(), .paragraphStyle: paragraph.copy()]
    }
    
    func ddqGetSizeToFitHeight() -> CGFloat {
        
        let fontLineH = self.font.lineHeight
        if self.attributedText != nil {
            if self.numberOfLines == 0 {
                return CGFloat.greatestFiniteMagnitude
            }

            var lineSpacing: CGFloat = 0.0
            if let attributes = self.attributedText?.attributes {
                if let paragraph = attributes[NSAttributedString.Key.paragraphStyle.rawValue] as? NSParagraphStyle {
                    lineSpacing = paragraph.lineSpacing
                }
            }
            
            return fontLineH * self.numberOfLines.ddqToCGFloat() + (self.numberOfLines - 1).ddqToCGFloat() * lineSpacing
        }
        
        if self.numberOfLines == 0 {
            return .greatestFiniteMagnitude
        }
        
        return fontLineH * self.numberOfLines.ddqToCGFloat()
    }
}

public extension UIImage {
    class func ddqImage(imageName: String?) -> UIImage? {
        return Self.ddqImage(imageName: imageName, mode: .automatic)
    }
    
    class func ddqImage(imageName: String?, mode: UIImage.RenderingMode) -> UIImage? {
        guard imageName != nil else {
            return nil
        }

        return self.init(named: imageName!)?.withRenderingMode(mode)
    }
    
    func ddqScaleImageToSize(size: CGSize) -> UIImage? {

        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        self.draw(in: CGRect.init(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func ddqScaleImageForWidth(width: CGFloat) -> UIImage? {
        
        let height = width * size.height / size.width
        return ddqScaleImageToSize(size: CGSize(width: width, height: height))
    }
    
    // 将图片压缩至对应大小，传kb
    func ddqScaleImageToBitSize(size: Int) -> UIImage? {
        
        let bit: Int = size * 1024
        var startQuality: CGFloat = 0.95
        let minQuality: CGFloat = 0.1
        let type: YYImageType = .JPEG
        var imageData: Data = YYImageEncoder.encode(self, type: type, quality: startQuality) ?? Data.init()
        while imageData.count > bit || startQuality > minQuality {
            
            startQuality -= 0.1
            imageData = YYImageEncoder.encode(self, type: type, quality: startQuality) ?? Data.init()
        }
        
        return UIImage(data: imageData, scale: UIScreen.main.scale)
    }
    
    // 不能超过32k
    func ddqScaleImageToWeChatSize() -> UIImage? {
        return ddqScaleImageToBitSize(size: 31)
    }
    
    func ddqScaleImageToQuality(q: CGFloat) -> UIImage? {
        if let imageData: Data = self.sd_imageData(as: .JPEG, compressionQuality: q.ddqToDouble()) {
            return UIImage.init(data: imageData, scale: UIScreen.main.scale)
        }
        
        return nil
    }
    
    func ddqToBase64String() -> String? {
        if let imageData = self.sd_imageData() {
            return imageData.base64EncodedString()
        }
        
        return nil
    }
    
    class func ddqImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        
        let view = UIView.ddqView(defaultBackgroundColor: color)
        view.frame = .init(origin: .zero, size: size)
        var image: UIImage = .init()
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext() {
         
            view.layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext() ?? .init()
        }
        
        UIGraphicsEndImageContext()
        return image
    }
    
    fileprivate class func _imageDefaultSize() -> CGSize {
        return .init(width: ddqScreenWidth, height: 44.0)
    }
    
    @available(iOS 13.0, *)
    class func ddqImageWithUserStyle(style: UIUserInterfaceStyle, size: CGSize) -> UIImage {
        return style == .light ? ddqImageWithColor(color: .white, size: size) : ddqImageWithColor(color: .black, size: size)
    }
    
    @available(iOS 13.0, *)
    class func ddqImageWithUserStyle(style: UIUserInterfaceStyle) -> UIImage {
        return ddqImageWithUserStyle(style: style, size: _imageDefaultSize())
    }
    
    class func ddqImageInUserStyle() -> UIImage {
        if #available(iOS 13.0, *) {
            return ddqImageWithUserStyle(style: UITraitCollection.current.userInterfaceStyle, size: _imageDefaultSize())
        }
        
        return ddqImageWithColor(color: .white, size: _imageDefaultSize())
    }
}

public extension UIView {
    struct OriginSaveKey {
        static var saveKey = "saveOriginData"
    }
    
    typealias RawValue = String
    struct OriginDataKey: Hashable, RawRepresentable {
        
        public var rawValue: RawValue
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
    
    var ddqOriginData: [OriginDataKey: Any] {
        get {
            if let data = objc_getAssociatedObject(self, &OriginSaveKey.saveKey) as? [OriginDataKey: Any] {
                return data
            }
            
            return [:]
        }
        
        set {
            objc_setAssociatedObject(self, &OriginSaveKey.saveKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}

public extension UIView.OriginDataKey {
    
    static let backgroundColor: UIView.OriginDataKey = .init(rawValue: "backgroundColor")
    static let titleColor: UIView.OriginDataKey = .init(rawValue: "titleColor")
    static let borderColor: UIView.OriginDataKey = .init(rawValue: "borderColor")
    static let text: UIView.OriginDataKey = .init(rawValue: "text")
    static let image: UIView.OriginDataKey = .init(rawValue: "image")
    static let backgroundImage: UIView.OriginDataKey = .init(rawValue: "backgroundImage")
}
