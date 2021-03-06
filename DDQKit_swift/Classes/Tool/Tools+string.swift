//
//  Tools+string.swift
//  BQRealtor
//
//  Created by MyNameDDQ on 2021/6/23.
//

import Foundation
import AdSupport
import CoreTelephony
import SAMKeychain
import YYKit
import UIKit

public extension String {
    func ddqTrimmingWhitespacesAndNewlines() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func ddqHTMLTextToAttributedString(dic: [NSAttributedString.Key: Any]?) -> NSAttributedString? {
        
        var attributedString: NSAttributedString?
        do {
            attributedString = try NSAttributedString.init(data: self.data(using: Encoding.utf8) ?? Data(), options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch {
            NSLog("转换html字符串失败")
        }
        
        return attributedString
    }
    
    var ddqLength: Int {
        return (self as NSString).length
    }
    
    func ddqSize(attributes: [NSAttributedString.Key: Any]) -> CGSize {
        
        let attrText: NSAttributedString = .init(string: self, attributes: attributes)
        let label = UILabel.ddqLabel()
        label.attributedText = attrText
        label.sizeToFit()
        return label.ddqSize
    }
}

public extension String {
    enum DDQTimeStampType: Int {
        
        case second
        case millisecond
        case microsecond
    }

    static func ddqGetTimeStamp(type: DDQTimeStampType) -> Double {
        
        let date = Date()
        var timeStamp = date.timeIntervalSince1970
        if type == .millisecond {
            timeStamp *= 1000
        } else if type == .microsecond {
            timeStamp *= (1000 * 1000)
        }
        
        return timeStamp
    }
    
    static func ddqGetTimeStamp() -> Double {
        return ddqGetTimeStamp(type: .second)
    }
}

public extension String {
    func ddqIsPhoneNumber() -> Bool {
        
        let string = self.ddqTrimmingWhitespacesAndNewlines()
        let regex = "^((13[0-9])|(14[5,7])|(15[^4,\\D]) |(17[0,0-9])|(18[0,0-9]))\\d{8}$"
        let predicate: NSPredicate = .init(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: string)
    }
}

public extension String {
    func ddqGetUrlKeyValues() -> [String: String] {
        
        let items = ddqUrlHaveQueryValue()
        guard items != nil else {
            return [:]
        }
        
        var keyValues: [String: String] = [:]
        for item in items! {
            keyValues.updateValue(item.value ?? "", forKey: item.name)
        }
        
        return keyValues
    }

    func ddqGetUrlValueForKey(key: String) -> String {

        let keyValues = ddqGetUrlKeyValues()
        guard !keyValues.isEmpty else {
            return String()
        }
        
        return keyValues[key] ?? String()
    }
    
    func ddqGetUrlValueForKeys(keys: [String]) -> [String: String] {
        
        let keyValues = ddqGetUrlKeyValues()
        guard !keyValues.isEmpty else {
            return [:]
        }

        var values: [String: String] = [:]
        for key in keyValues.keys {
            if keys.contains(key) {
                values.updateValue(keyValues[key] ?? String(), forKey: key)
            }
        }
        
        return values
    }
    
    func ddqUrlHaveQueryValue() -> [URLQueryItem]? {
        
        let components = URLComponents.init(string: self)
        return components?.queryItems
    }
    
    func ddqAppendUrlQueryWithKeyValues(dic: [String: String]) -> String {
        
        var components = URLComponents(string: self)
        guard components != nil else {
            return self
        }
        
        var items: [URLQueryItem] = []
        var existKeyValues = ddqGetUrlKeyValues()
        if existKeyValues.isEmpty {
            for (key, value) in dic {
                
                let item = URLQueryItem.init(name: key, value: value)
                items.ddqAppend(element: item)
            }
        } else {
            
            let notExist = dic.filter { (element) -> Bool in
                if existKeyValues.keys.contains(element.key) {// 更新已有item
                    
                    existKeyValues.updateValue(element.value, forKey: element.key)
                    return false
                }
                return true
            }
            
            for (key, value) in existKeyValues {
                
                let item = URLQueryItem(name: key, value: value)
                items.ddqAppend(element: item)
            }
            
            for (key, value) in notExist {// 拼接剩下数据
                
                let item = URLQueryItem(name: key, value: value)
                items.ddqAppend(element: item)
            }
        }
        
        components?.queryItems = items
        return components?.url?.absoluteString ?? self
    }
}

public extension String {
    static func ddqGetAppVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    static func ddqGetDisplayName() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    }
    
    static func ddqGetBundleId() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as! String
    }
            
    static func ddqGetDeviceBrand() -> String {
        return UIDevice.current.model
    }
    
    static func ddqGetDeviceID() -> String {
        
        let service = String.ddqGetBundleId()
        guard let password = SAMKeychain.password(forService: service, account: "uuid") else {
            
            var uuid = UIDevice.current.identifierForVendor?.uuidString
            uuid = uuid?.replacingOccurrences(of: "-", with: "").lowercased()
            SAMKeychain.setPassword(uuid ?? "", forService: service, account: "uuid")
            return uuid ?? ""
        }
        
        return password
    }
    
    static func ddqGetDeviceIp() -> String {
        
        var addresses: [String] = []
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        if getifaddrs(&ifaddr) == 0 {
            
            var ptr = ifaddr
            while ptr != nil {
                
                let flags = Int32(ptr!.pointee.ifa_flags)
                var addr = ptr!.pointee.ifa_addr.pointee
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST) == 0 {
                            if let address = String(validatingUTF8: hostname) {
                                addresses.append(address)
                            }
                        }
                    }
                }
                
                ptr = ptr!.pointee.ifa_next
            }
            
            freeifaddrs(ifaddr)
        }
        
        guard let ipStr = addresses.first else {
            return ""
        }
        
        return ipStr
    }
    
    // 运营商
    static func ddqGetDeviceProvider() -> String {
        
        let info = CTTelephonyNetworkInfo()
        var supplier: String = ""
        if #available(iOS 12.0, *) {
            if let carriers = info.serviceSubscriberCellularProviders {
                if carriers.keys.count == 0 {
                    return ""
                } else { // 获取运营商信息
                    for (index, carrier) in carriers.values.enumerated() {
                        if let carrierName = carrier.carrierName {
                            // 查看运营商信息 通过CTCarrier类
                            if index == 0 {
                                supplier = carrierName
                            } else {
                                supplier = supplier.appendingFormat(",%@", carrierName)
                            }
                        }
                    }
                    
                    return supplier
                }
            } else {
                return ""
            }
        } else {
            if let carrier = info.subscriberCellularProvider {
                guard carrier.carrierName != nil else {
                    return ""
                }
                
                return carrier.carrierName!
                
            } else {
                return ""
            }
        }
    }
    
    func ddqValidateNewestAppVersion(newest version: String) -> Bool {
        if self.isEmpty || version.isEmpty {
            return false
        }
        
        let current: [String] = self.components(separatedBy: ".")
        guard !current.isEmpty else {
            return false
        }
        
        let newest: [String] = version.components(separatedBy: ".")
        guard !newest.isEmpty else {
            return false
        }
        
        var need = false
        for cChar in current {
            
            let number: Int = Int(cChar) ?? 0
            let index = current.firstIndex(of: cChar) ?? 0
            let nChar = newest.ddqObject(at: index)
            if nChar == nil {
                break
            }
            
            let nNumber: Int = Int(nChar ?? "0") ?? 0
            if nNumber > number {
                
                need = true
                break
            }
        }
        return need
    }
        
    static func ddqGetDeviceModel() -> String {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machine = Mirror(reflecting: systemInfo.machine)
        let identifier = machine.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
            
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        //https://blog.csdn.net/qq_19926599/article/details/86747401
        switch identifier {
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":
            return "iPhone4"
            
        case "iPhone4,1":
            return "iPhone4s"
            
        case "iPhone5,1", "iPhone5,2":
            return "iPhone5"
            
        case "iPhone5,3", "iPhone5,4":
            return "iPhone5c"
            
        case "iPhone6,1", "iPhone6,2":
            return "iPhone5s"
            
        case "iPhone7,2":
            return "iPhone6"
            
        case "iPhone7,1":
            return "iPhone6Plus"
            
        case "iPhone8,1":
            return "iPhone6s"
            
        case "iPhone8,2":
            return "iPhone6sPlus"
            
        case "iPhone9,1":
            return "iPhone7"
            
        case "iPhone9,2":
            return "iPhone7Plus"
            
        case "iPhone8,3", "iPhone8,4":
            return "iPhoneSE"
            
        case "iPhone10,1", "iPhone10,4":
            return "iPhone8"
            
        case "iPhone10,2", "iPhone10,5":
            return "iPhone8Plus"
            
        case "iPhone10,3", "iPhone10,6":
            return "iPhoneX"
            
        case "iPhone11,2":
            return "iPhoneXS"
            
        case "iPhone11.4", "iPhone11,6":
            return "iPhoneXSMax"
            
        case "iPhone11,8":
            return "iPhoneXR"
            
        case "iPhone12,1":
            return "iPhone11"
            
        case "iPhone12,3":
            return "iPhone11Pro"
            
        case "iPhone12,5":
            return "iPhone11ProMax"
            
        case "iPhone12,8":
            return "iPhoneSE"
            
        case "iPhone13,1":
            return "iPhone12Mini"
            
        case "iPhone13,2":
            return "iPhone12"
            
        case "iPhone13,3":
            return "iPhone12Pro"
            
        case "iPhone13,4":
            return "iPhone12ProMax"
            
        case "i386", "x86_64":
            return "Simulator"
            
        default:
            return identifier
        }
    }
}

public extension String {
    func ddqToDateString(formatter: String?) -> String {
        
        let date = Date(timeIntervalSince1970: self.ddqToDouble())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter ?? "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    func ddqToTimeStamp(formatter: String?) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter ?? "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: self) {
            return String(format: "%.f", date.timeIntervalSince1970)
        }
        
        return ""
    }
    
    func ddqToDateDescription() -> String {
        guard !self.isEmpty else {
            return ""
        }
        
        let date = Date(timeIntervalSince1970: (Double(self) ?? 0.0))
        let currentDate = Date()
        var desc = ""
        let oneMin = 60.0
        let oneHour = 60 * oneMin
        let oneDay = 24 * oneHour
        let oneMonth = 30 * oneDay
        let diff = currentDate.timeIntervalSince1970 - date.timeIntervalSince1970
        if diff <= 5 * oneMin {
            desc = "刚刚"
        } else {
            if diff > oneMonth {
                desc = String(format: "%.0f月前", diff / oneMonth)
            } else if diff > oneDay {
                desc = String(format: "%.0f天前", diff / oneDay)
            } else if diff > oneHour {
                desc = String(format: "%.0f小时前", diff / oneHour)
            } else {
                desc = String(format: "%.0f分钟前", diff / oneMin)
            }
        }
        
        return desc
    }
}

public extension String {
    func ddqToQRCodeImage(size: CGSize) -> UIImage? {
        
        let filter = CIFilter.init(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        let data = self.data(using: Encoding.utf8)
        filter?.setValue(data ?? Data(), forKey: "inputMessage")
        filter?.setValue("H", forKey: "inputCorrectionLevel")
        let ciImage = filter?.outputImage
        if ciImage == nil { return nil }
        return UIImage(ciImage: ciImage!)
    }
        
    func ddqBase64ToImage() -> UIImage? {
        if let data = self.ddqBase64StringToData() {
            return UIImage.init(data: data)
        }
    
        return nil
    }
}
