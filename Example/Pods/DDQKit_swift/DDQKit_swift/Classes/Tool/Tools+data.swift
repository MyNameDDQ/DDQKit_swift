//
//  Tools+data.swift
//  BQRealtor
//
//  Created by MyNameDDQ on 2021/6/23.
//

import Foundation

public extension Dictionary {
    func ddqToData() -> Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: .fragmentsAllowed)
    }
    
    func ddqToJsonString() -> String? {
        guard let data = self.ddqToData() else {
            return nil
        }
        
        guard let jsonString = String.init(data: data, encoding: .utf8) else {
            return nil
        }
                
        return jsonString.ddqTrimmingWhitespacesAndNewlines()
    }
}

public extension Array {
    func ddqToData() -> Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: .fragmentsAllowed)
    }

    func ddqToJsonString() -> String? {
        guard let data = self.ddqToData() else {
            return nil
        }
        
        guard let jsonString = String.init(data: data, encoding: .utf8) else {
            return nil
        }
                
        return jsonString.ddqTrimmingWhitespacesAndNewlines()
    }
}

public extension String {
    func ddqToData() -> Data? {
        return self.data(using: .utf8)
    }
    
    func ddqBase64StringToData() -> Data? {
        return Data.init(base64Encoded: self)
    }
    
    func ddqToMD5() -> String? {
        
        let _nsstring = self as NSString
        return _nsstring.md5()
    }
    
    func ddqToBase64() -> String? {
        return self.ddqToData()?.ddqToBase64()
    }
}

public extension Data {
    func ddqToBase64() -> String {
        return self.base64EncodedString()
    }
    
    func ddqToMD5() -> String? {
        return String.init(data: self, encoding: .utf8)?.ddqToMD5()
    }
    
    func ddqToJson() -> Any? {
        return try? JSONSerialization.jsonObject(with: self, options: .fragmentsAllowed)
    }
}
