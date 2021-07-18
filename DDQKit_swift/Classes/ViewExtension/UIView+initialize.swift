//
//  UIView+initialize.swift
//  BQRealtor
//
//  Created by MyNameDDQ on 2021/5/22.
//

import UIKit
import MJRefresh
import SDWebImage

public enum DDQMJHeaderRefresh: Int {
    
    case none
    case normal
    case gif
    case state
}

public enum DDQMJFooterRefresh: Int {
    
    case none
    case auto
    case back
    case autoNormal
    case backNormal
    case autoGIF
    case backGIF
    case autoState
    case backState
}

public extension UIView {
    class func ddqView() -> UIView {
        
        let view = self.init()
        view.backgroundColor = .ddqBackgroundColor()
        return view
    }
    
    class func ddqView(defaultBackgroundColor color: UIColor?) -> UIView {
        
        let view = self.ddqView()
        if let c = color {
            view.backgroundColor = c
        }
        
        return view
    }
    
    func ddqAddSubViews(subViews views: [UIView]?) {
        guard (views?.count ?? 0) > 0 else {
            return
        }
        
        for view in views! {
            self.addSubview(view)
        }
    }
    
    func ddqRemoveSubViews(subViews views: [UIView]?) {
        guard (views?.count ?? 0) > 0 else {
            return
        }

        for view in views! {
            if self.subviews.contains(view) {
                view.removeFromSuperview()
            }
        }
    }
    
    func ddqRemoveAllSubViews() {
        self.ddqRemoveSubViews(subViews: self.subviews)
    }
    
    func ddqSubviewsWithClass(vClass: AnyClass?) -> [UIView]? {
        guard vClass != nil else {
            return nil
        }
       
        let filters = self.subviews.filter { (view) -> Bool in
            return type(of: view).isEqual(vClass)
        }
        
        return filters
    }
    
    func ddqRemoveSubViews(viewClass vClass: AnyClass?) {
        self.ddqRemoveSubViews(subViews: self.ddqSubviewsWithClass(vClass: vClass))
    }
    
    func ddqAddTapGestureRecognizer(action: @escaping(UITapGestureRecognizer) -> Void) -> UITapGestureRecognizer {

        let tap = UITapGestureRecognizer.init { (gr: Any) in
            action(gr as! UITapGestureRecognizer)
        }
        
        self.addGestureRecognizer(tap)
        return tap
    }

    func ddqAddLongPressGestureRecognizer(action: @escaping(UILongPressGestureRecognizer) -> Void) -> UILongPressGestureRecognizer {

        let longPress = UILongPressGestureRecognizer.init { (gr: Any) in
            action(gr as! UILongPressGestureRecognizer)
        }
        
        self.addGestureRecognizer(longPress)
        return longPress
    }

    func ddqAddSwipeGestureRecognizer(action: @escaping(UISwipeGestureRecognizer) -> Void) -> UISwipeGestureRecognizer {

        let swipe = UISwipeGestureRecognizer.init { (gr: Any) in
            action(gr as! UISwipeGestureRecognizer)
        }
        
        self.addGestureRecognizer(swipe)
        return swipe
    }

    func ddqAddPanGestureRecognizer(action: @escaping(UIPanGestureRecognizer) -> Void) -> UIPanGestureRecognizer {

        let pan = UIPanGestureRecognizer.init { (gr: Any) in
            action(gr as! UIPanGestureRecognizer)
        }
        
        self.addGestureRecognizer(pan)
        return pan
    }
}

public extension UILabel {
    class func ddqLabel() -> UILabel {
        
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.numberOfLines = 0
        label.font = .ddqFont()
        label.textColor = .ddqTextColor()
        label.backgroundColor = .ddqBackgroundColor()
        return label
    }
    
    class func ddqLabel(text: String?) -> UILabel {
        return ddqLabel(text: text, font: nil, textColor: nil)
    }
    
    class func ddqLabel(text: String?, font: UIFont?) -> UILabel {
        return ddqLabel(text: text, font: font, textColor: nil)
    }

    class func ddqLabel(text: String?, font: UIFont?, textColor: UIColor?) -> UILabel {
        
        let label = ddqLabel()
        label.text = text ?? ""
        if let f = font {
            label.font = f
        }
        
        if let c = textColor {
            label.textColor = c
        }
        return label
    }
    
    class func ddqAttributedLabel(attributeText: NSAttributedString?) -> UILabel {
        
        let label = ddqLabel()
        label.attributedText = attributeText
        return label
    }

    class func ddqAttributedLabel(text: String?, attributes: [NSAttributedString.Key: Any]?) -> UILabel {
        
        let attributedText = NSAttributedString.init(string: text ?? "", attributes: attributes ?? ddqAttributes())
        return ddqAttributedLabel(attributeText: attributedText)
    }

    func ddqLabelSizeThatBounding(options: NSStringDrawingOptions, size: CGSize) -> CGSize {
        guard let attributd = self.attributedText else {
            return self.text?.boundingRect(with: size, options: options, attributes: nil, context: nil).size ?? CGSize.zero
        }
        
        return attributd.boundingRect(with: size, options: options, context: nil).size
    }
}

public extension UIButton {
    
    typealias DDQButtonActionBlock = (_ button: UIButton) -> Void
    class func ddqButton() -> UIButton {
        
        let button = UIButton.init(type: .custom)
        button.backgroundColor = .clear
        button.setTitleColor(.ddqTextColor(), for: .normal)
        button.titleLabel?.font = .ddqFont()
        var data: [OriginDataKey: Any] = [:]
        data.updateValue(button.backgroundColor!, forKey: .backgroundColor)
        data.updateValue(button.titleColor(for: .normal)!, forKey: .titleColor)
        button.ddqOriginData.ddqAddEntries(other: data)
        return button
    }
    
    class func ddqButton(title: String?, image: UIImage?, backgroundImage: UIImage?, titleColor: UIColor?, event: UIButton.Event?, action: DDQButtonActionBlock?) -> UIButton {
        
        let button = ddqButton()
        var data: [OriginDataKey: Any] = [:]
        if let t = title {
            
            button.setTitle(t, for: .normal)
            data.updateValue(t, forKey: .text)
        }
        
        if let i = image {
            
            button.setImage(i, for: .normal)
            data.updateValue(i, forKey: .image)
        }
        
        if let b = backgroundImage {
            
            button.setBackgroundImage(backgroundImage, for: .normal)
            data.updateValue(b, forKey: .backgroundImage)
        }
        
        if action != nil {
            
            button.addBlock(for: event ?? .touchUpInside) { (target: Any) in
                action!(target as! UIButton)
            }
        }
        
        if let titleC = titleColor {
            
            button.setTitleColor(titleC, for: .normal)
            data.updateValue(titleC, forKey: .titleColor)
        }
        
        button.ddqOriginData.ddqAddEntries(other: data)
        return button
    }

    class func ddqButton(title: String?, image: UIImage?, event: UIButton.Event?, action: DDQButtonActionBlock?) -> UIButton {
        return ddqButton(title: title, image: image, backgroundImage: nil, titleColor: nil, event: event, action: action)
    }
    
    class func ddqButton(title: String?, event: UIButton.Event?, action: DDQButtonActionBlock?) -> UIButton {
        return ddqButton(title: title, image: nil, event: event, action: action)
    }
    
    class func ddqButton(image: UIImage?, event: UIButton.Event?, action: DDQButtonActionBlock?) -> UIButton {
        return ddqButton(title: nil, image: image, event: event, action: action)
    }
    
    class func ddqButton(title: String?, image: UIImage?, backgroundImage: UIImage?, titleColor: UIColor?, event: UIButton.Event, target: Any, selector: Selector) -> UIButton {
        
        let button = ddqButton()
        button.setTitle(title, for: .normal)
        button.setImage(image, for: .normal)
        button.setBackgroundImage(backgroundImage ?? nil, for: .normal)
        button.addTarget(target, action: selector, for: event)
        if let titleC = titleColor {
            button.setTitleColor(titleC, for: .normal)
        }
        
        return button
    }
    
    class func ddqButton(title: String?, image: UIImage?, event: UIButton.Event, target: Any, selector: Selector) -> UIButton {
        return ddqButton(title: title, image: image, backgroundImage: nil, titleColor: nil, event: event, target: target, selector: selector)
    }
    
    class func ddqButton(title: String?, event: UIButton.Event, target: Any, selector: Selector) -> UIButton {
        return ddqButton(title: title, image: nil, event: event, target: target, selector: selector)
    }
    
    class func ddqButton(image: UIImage?, event: UIButton.Event, target: Any, selector: Selector) -> UIButton {
        return ddqButton(title: nil, image: image, event: event, target: target, selector: selector)
    }
    
    func ddqChangeToOriginData() {
        guard !self.ddqOriginData.isEmpty else {
            return
        }
        
        if let background = self.ddqOriginData[.backgroundColor] as? UIColor {
            self.backgroundColor = background
        }
        
        if let bimage = self.ddqOriginData[.backgroundImage] as? UIImage {
            self.setBackgroundImage(bimage, for: .normal)
        }
        
        if let image = self.ddqOriginData[.image] as? UIImage {
            self.setImage(image, for: .normal)
        }
        
        if let text = self.ddqOriginData[.text] as? String {
            self.setTitle(text, for: .normal)
        }
        
        if let textColor = self.ddqOriginData[.titleColor] as? UIColor {
            self.setTitleColor(textColor, for: .normal)
        }
        
        if let borderColor = self.ddqOriginData[.borderColor] as? UIColor {
            self.layer.borderColor = borderColor.cgColor
        }
    }

    func ddqSet(title: String?, image: UIImage?, backgroundImage: UIImage?, event: UIButton.Event?, action: DDQButtonActionBlock?) {
        
        if let t = title {
            self.setTitle(t, for: .normal)
        }
        
        if let i = image {
            self.setImage(i, for: .normal)
        }

        if let b = backgroundImage {
            self.setBackgroundImage(b, for: .normal)
        }

        if action != nil {
            
            self.addBlock(for: event ?? .touchUpInside) { (button) in
                action!(button as! UIButton)
            }
        }
    }
    
    func ddqSet(title: String?, image: UIImage?, event: UIButton.Event?, action: DDQButtonActionBlock?) {
        self.ddqSet(title: title, image: image, backgroundImage: nil, event: event, action: action)
    }

    func ddqSet(title: String?, event: UIButton.Event?, action: DDQButtonActionBlock?) {
        self.ddqSet(title: title, image: nil, event: event, action: action)
    }
    
    func ddqSet(image: UIImage?, event: UIButton.Event?, action: DDQButtonActionBlock?) {
        self.ddqSet(title: nil, image: image, event: event, action: action)
    }
    
    func ddqSet(event: UIButton.Event?, action: DDQButtonActionBlock?) {
        self.ddqSet(title: nil, image: nil, event: event, action: action)
    }
    
    func ddqSet(title: String?, image: UIImage?) {
        self.ddqSet(title: title, image: image, event: nil, action: nil)
    }
}

public extension UITextField {
    class func ddqTextField() -> UITextField {
        
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textColor = .ddqTextColor()
        textField.font = .ddqFont()
        return textField
    }
    
    class func ddqTextField(placeholder: String?, placeholderAttrs: [NSAttributedString.Key: Any]?, font: UIFont?, textColor: UIColor?, delegate: UITextFieldDelegate?) -> UITextField {
        
        let textField = ddqTextField()
        if placeholder != nil {
            
            let attrPlaceholder = NSMutableAttributedString.init(string: placeholder!)
            if placeholderAttrs != nil {
                attrPlaceholder.addAttributes(placeholderAttrs!, range: NSRange.init(placeholder!) ?? NSRange())
            }
            textField.attributedPlaceholder = attrPlaceholder
        }
        
        textField.delegate = delegate ?? nil
        if let f = font {
            textField.font = f
        }
        
        if let c = textColor {
            textField.textColor = c
        }
        return textField
    }
    
    class func ddqTextField(placeholder: String?, delegate: UITextFieldDelegate?) -> UITextField {
        return ddqTextField(placeholder: placeholder, placeholderAttrs: nil, font: nil, textColor: nil, delegate: delegate)
    }
    
    class func ddqTextField(placeholder: String?) -> UITextField {
        return ddqTextField(placeholder: placeholder, placeholderAttrs: nil, font: nil, textColor: nil, delegate: nil)
    }
}

public extension UIImageView {
    class func ddqImageView() -> UIImageView {
        
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }
    
    class func ddqImageView(imageName: String?) -> UIImageView {
        
        let imageView = ddqImageView()
        guard imageName != nil else {
            return imageView
        }
        
        imageView.image = UIImage.ddqImage(imageName: imageName)
        return imageView
    }
    
    class func ddqImageView(image: UIImage?) -> UIImageView {
        
        let imageView = ddqImageView()
        guard image != nil else {
            return imageView
        }
        
        imageView.image = image
        return imageView
    }
    
    class func ddqImageView(imageUrl: String?, placeholderName: String?) -> UIImageView {
        
        let imageView = ddqImageView()
        guard imageUrl != nil else {
            return imageView
        }
        
        imageView.sd_setImage(with: URL.init(string: imageUrl!), placeholderImage: UIImage.init(named: placeholderName ?? ""))
        return imageView
    }
    
    class func ddqImageView(gift images: [Any]?) -> UIImageView {
        
        let imageView = ddqImageView()
        if images?.first is String {
            
            let images① = NSMutableArray()
            for objc in images! {
                
                let name = objc as! String
                let image = UIImage.ddqImage(imageName: name)
                images①.add(image!)
            }
            imageView.animationImages = images① as? [UIImage]
            imageView.startAnimating()
            return imageView
        
        } else if images?.first is UIImage {
            
            imageView.animationImages = images! as? [UIImage]
            imageView.startAnimating()
            return imageView
        
        } else {
            return imageView
        }
    }
    
    func ddqWithRendering(rendering: UIImage.RenderingMode) -> UIImageView {
        guard self.image != nil else {
            return self
        }
        
        let image = self.image?.withRenderingMode(rendering)
        self.image = image
        return self
    }
}

public extension UIScrollView {
    class func ddqScrollView() -> UIScrollView {
        
        let scrollView = UIScrollView(frame: CGRect.zero)
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .ddqBackgroundColor()
        return scrollView
    }
    
    typealias DDQMJRefreshHeaderBlock = (_ view: UIScrollView) -> Void
    typealias DDQMJRefreshFooterBlock = (_ view: UIScrollView) -> Void
    
    func ddqSetRefresh(header: DDQMJHeaderRefresh, footer: DDQMJFooterRefresh, headerAction: DDQMJRefreshHeaderBlock?, footerAction: DDQMJRefreshFooterBlock?) {
        if header != .none {
            
            var hClass = MJRefreshHeader.self
            switch header {
            case .normal:
                hClass = MJRefreshNormalHeader.self
                
            case .state:
                hClass = MJRefreshStateHeader.self
                
            case .gif:
                hClass = MJRefreshGifHeader.self
                
            default:
                break
            }
            
            let headerC = hClass.init {
                if headerAction !=  nil {
                    headerAction!(self)
                }
            }
            
            self.mj_header = headerC
        }
        
        if footer != .none {
            
            var fClass = MJRefreshFooter.self
            switch footer {
            case .auto:
                fClass = MJRefreshAutoFooter.self
                                
            case .autoNormal:
                fClass = MJRefreshAutoNormalFooter.self
                
            case .autoGIF:
                fClass = MJRefreshAutoGifFooter.self
                
            case .autoState:
                fClass = MJRefreshAutoStateFooter.self

            case .back:
                fClass = MJRefreshBackFooter.self
                
            case .backGIF:
                fClass = MJRefreshBackGifFooter.self

            case .backState:
                fClass = MJRefreshBackStateFooter.self

            case .backNormal:
                fClass = MJRefreshBackNormalFooter.self
            
            default:
                break
            }
            
            let footerC = fClass.init {
                if footerAction !=  nil {
                    footerAction!(self)
                }
            }
            
            self.mj_footer = footerC
        }
    }
    
    func ddqEndRefresh(notMore: Bool) {
        if self.mj_header?.isRefreshing == true {
            
            self.mj_header?.endRefreshing()
            
            if self.mj_footer != nil {
                self.mj_footer?.resetNoMoreData()
            }
        }
        
        if self.mj_footer?.isRefreshing == true {
            self.mj_footer?.endRefreshing()
        }
        
        if notMore {
            self.mj_footer?.endRefreshingWithNoMoreData()
        }
    }
    
    func ddqRemoveHeaderFooter() {
        
        self.mj_header?.endRefreshing()
        self.mj_header = nil
        self.mj_footer?.endRefreshing()
        self.mj_footer = nil
    }
}

public extension UITableView {
    class var ddqCellIdentifier: String {
        return NSStringFromClass(Self.ddqCellClass)
    }
    
    class var ddqCellClass: AnyClass {
        return DDQCell.self
    }
    
    class var ddqHeaderFooterIdentifier: String {
        return "com.ddq.default.headerFooterView"
    }
    
    class var ddqHeaderFooterClass: AnyClass {
        return UITableViewHeaderFooterView.self
    }
    
    class func ddqTableView(style: Style) -> UITableView {
        
        let tableView = UITableView.init(frame: CGRect.zero, style: style)
        tableView.estimatedRowHeight = 0.0
        tableView.estimatedSectionHeaderHeight = 0.0
        tableView.estimatedSectionFooterHeight = 0.0
        tableView.contentInset = .zero
        tableView.register(ddqCellClass, forCellReuseIdentifier: ddqCellIdentifier)
        tableView.register(ddqHeaderFooterClass, forHeaderFooterViewReuseIdentifier: ddqHeaderFooterIdentifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }
        
        tableView.backgroundColor = .ddqBackgroundColor()
        return tableView
    }
    
    class func ddqTableView(style: Style, delegate: UITableViewDelegate?, dataSource: UITableViewDataSource?) -> UITableView {
        
        let tableView = ddqTableView(style: style)
        tableView.delegate = delegate ?? nil
        tableView.dataSource = dataSource ?? nil
        return tableView
    }
    
    class func ddqTableView(style: Style, delegate: UITableViewDelegate?, dataSource: UITableViewDataSource?, h: DDQMJHeaderRefresh, f: DDQMJFooterRefresh, ha: DDQMJRefreshHeaderBlock?, fa: DDQMJRefreshFooterBlock?) -> UITableView {
        
        let tableView = ddqTableView(style: style, delegate: delegate, dataSource: dataSource)
        tableView.ddqSetRefresh(header: h, footer: f, headerAction: ha, footerAction: fa)
        return tableView
    }
}

public extension UICollectionView {
    class var ddqItemIdentifier: String {
        return NSStringFromClass(Self.ddqItemClass)
    }
    
    class var ddqItemClass: AnyClass {
        return DDQItem.self
    }
    
    class var ddqHeaderFooterIdentifier: String {
        return "com.ddq.default.reuseView"
    }
    
    class var ddqHeaderFooterClass: AnyClass {
        return UICollectionReusableView.self
    }
    
    class func ddqDefaultFlowLayout() -> UICollectionViewFlowLayout {
        
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = .zero
        return flowLayout
    }
    
    class func ddqCollectionView(flowLayout: UICollectionViewFlowLayout?) -> UICollectionView {
        
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout ?? ddqDefaultFlowLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ddqItemClass, forCellWithReuseIdentifier: ddqItemIdentifier)
        collectionView.register(ddqHeaderFooterClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ddqHeaderFooterIdentifier)
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }

        return collectionView
    }
    
    class func ddqCollectionView(layout: UICollectionViewFlowLayout?, delegate: UICollectionViewDelegate?, dataSource: UICollectionViewDataSource?) -> UICollectionView {
        
        let collectionView = ddqCollectionView(flowLayout: layout)
        collectionView.delegate = delegate ?? nil
        collectionView.dataSource = dataSource ?? nil
        return collectionView
    }
    
    class func ddqCollectionView(delegate: UICollectionViewDelegate?, dataSource: UICollectionViewDataSource?, h: DDQMJHeaderRefresh, f: DDQMJFooterRefresh, ha: DDQMJRefreshHeaderBlock?, fa: DDQMJRefreshFooterBlock?) -> UICollectionView {
        
        let collectionView = ddqCollectionView(layout: nil, delegate: delegate, dataSource: dataSource)
        collectionView.ddqSetRefresh(header: h, footer: f, headerAction: ha, footerAction: fa)
        return collectionView
    }
}

public extension DDQTextView {
    public var ddqBeginningRect: CGRect {
        return self.caretRect(for: self.beginningOfDocument)
    }
    
    class func ddqTextView(font: UIFont?, textColor: UIColor?, delegate: UITextViewDelegate?, container: NSTextContainer?) -> DDQTextView {
        
        let textView: DDQTextView!
        if container != nil {
            textView = DDQTextView.init(frame: CGRect.zero, textContainer: container)
        } else {
            textView = DDQTextView.init(frame: CGRect.zero)
        }
        
        textView.font = font ?? .ddqFont()
        textView.textColor = textColor ?? .ddqTextColor()
        return textView
    }
    
    class func ddqTextView() -> DDQTextView {
        return ddqTextView(font: nil, textColor: .ddqTextColor(), delegate: nil, container: nil)
    }
    
    class func ddqTextView(font: UIFont?, textColor: UIColor?) -> DDQTextView {
        return ddqTextView(font: font, textColor: textColor, delegate: nil, container: nil)
    }
}
