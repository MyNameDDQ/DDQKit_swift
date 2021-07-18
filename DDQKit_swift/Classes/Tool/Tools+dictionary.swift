//
//  Tools+dictionary.swift
//  BQRealtor
//
//  Created by MyNameDDQ on 2021/6/23.
//

import Foundation
import SwiftyJSON

public extension Dictionary where Key == String {
    private func _toJson() -> JSON {
        return JSON.init(self)
    }
    
    func ddqArrayWithKey(key: String) -> [Any] {
        return _toJson()[key].arrayObject ?? Array()
    }
    
    func ddqIntWithKey(key: String) -> Int {
        return _toJson()[key].intValue
    }
    
    func ddqDoubleWithKey(key: String) -> Double {
        return _toJson()[key].doubleValue
    }

    func ddqFloatWithKey(key: String) -> Float {
        return _toJson()[key].floatValue
    }
    
    func ddqBoolWithKey(key: String) -> Bool {
        return _toJson()[key].boolValue
    }
    
    func ddqStringWithKey(key: String) -> String {
        return _toJson()[key].stringValue
    }
    
    func ddqDictionaryWithKey(key: String) -> [Key: Any] {
        return _toJson()[key].dictionaryObject ?? Dictionary()
    }
}

public extension Dictionary {
    mutating func ddqAddEntries(other: [Key: Value]) {
        for (key, value) in other {
            self.updateValue(value, forKey: key)
        }
    }
}
