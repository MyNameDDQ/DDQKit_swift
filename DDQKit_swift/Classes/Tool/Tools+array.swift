//
//  Tools+array.swift
//  BQRealtor
//
//  Created by MyNameDDQ on 2021/6/23.
//

import Foundation

public extension Array where Element: Equatable {
    enum DDQArrayOperation {
        
        case aig // append insert getObjc
        case rr // remove replace
    }
    
    func ddqSafeOfIndex(index: Int, operation: DDQArrayOperation) -> Bool {
        if index < 0 {
            return false
        }

        if operation == .aig {
            return !isEmpty && index <= (endIndex - 1)
        } else {
            return !isEmpty && index <= endIndex
        }
    }
        
    func ddqIsFirstElement(element: Element) -> Bool {
        return element == self.first
    }
    
    func ddqIsLastElement(element: Element) -> Bool {
        return element == self.last
    }
    
    func ddqObject(at: Int) -> Element? {
        guard ddqSafeOfIndex(index: at, operation: .aig) else {
            return nil
        }
        
        return self[at]
    }
        
    mutating func ddqAppend(element: Element?) {
        guard let ele = element else {
            return
        }
        
        self.ddqAppend(array: [ele])
    }
    
    mutating func ddqAppend(array: [Element]?) {
        guard let data = array else {
            return
        }
        
        for element in data {
            if !self.contains(element) {
                
                self.append(element)
            }
        }
    }
    
    mutating func ddqInsert(element: Element, at: Int) {
        self.ddqInset(array: [element], at: at)
    }
    
    mutating func ddqInset(array: [Element], at: Int) {
        guard ddqSafeOfIndex(index: at, operation: .aig) else {
            
            self.ddqAppend(array: array)
            return
        }
        
        var index = at
        for element in array {
            
            self.insert(element, at: index)
            index += 1
        }
    }
        
    mutating func ddqRemove(at: Int) {
        self.ddqRemove(at: at, length: 1)
    }
    
    mutating func ddqRemove(at: Int, length: Int) {
        guard ddqSafeOfIndex(index: at + length, operation: .rr) else {
            
            NSLog("需要移除的数组长度：%d越界了，请检查数组长度：%d", at + length, self.count)
            return
        }
        
        self.removeSubrange(Range.init(NSRange.init(location: at, length: length)) ?? Range.init(0...0))
    }
    
    mutating func ddqRemove(array: [Element]) {
        array.forEach { (element) in
            if let index = self.firstIndex(of: element) {
                self.ddqRemove(at: index)
            }
        }
    }
                
    mutating func ddqReplace(element: Element, at: Int) {
        self.ddqReplace(array: [element], at: at)
    }
    
    mutating func ddqReplace(array: [Element], at: Int) {
        guard ddqSafeOfIndex(index: at + array.count, operation: .rr) else {
            
            NSLog("用以替换的数组：%@\n越界了，请检查数组长度：%@", array, self)
            return
        }
        
        self.ddqRemove(at: at, length: array.count)
        self.ddqInset(array: array, at: at)
    }
    
    typealias DDQForEachBlock = (_ objc: Element, _ index: Int) -> Void
    typealias DDQForEachBeforeAndLastBlock = (_ objc: Element, _ index: Int, _ beforeObjc: Element?, _ beforeIndex: Int?, _ lastObjc: Element?, _ lastIndex: Int?) -> Void
    typealias DDQForEachBeforeBlock = (_ objc: Element, _ index: Int, _ beforeObjc: Element?, _ beforeIndex: Int?) -> Void
    typealias DDQForEachLastBlock = (_ objc: Element, _ index: Int, _ lastObjc: Element?, _ lastIndex: Int?) -> Void

    func ddqForEach(block: DDQForEachBlock) {
        self.forEach { (element) in
            
            let index = self.firstIndex(of: element)!
            block(element, index)
        }
    }
    
    func ddqForEachWithBefore(block: DDQForEachBeforeBlock) {
        self.forEach { (element) in
            
            let index = self.firstIndex(of: element)!
            let beforeIndex = index - 1
            if self.ddqSafeOfIndex(index: beforeIndex, operation: .aig) {
                
                block(element, index, self[beforeIndex], beforeIndex)
            }
            
            block(element, index, nil, nil)
        }
    }
    
    func ddqForEachWithLast(block: DDQForEachLastBlock) {
        self.forEach { (element) in
            
            let index = self.firstIndex(of: element)!
            let lastIndex = index + 1
            if self.ddqSafeOfIndex(index: lastIndex, operation: .aig) {
                
                block(element, index, self[lastIndex], lastIndex)
            }
            
            block(element, index, nil, nil)
        }
    }
    
    func ddqForEachWithBeforeAndLast(block: DDQForEachBeforeAndLastBlock) {
        self.forEach { (element) in
            
            let index = self.firstIndex(of: element)!
            
            let bIndex = index - 1
            var beforeObjc: Element?
            var beforeIndex: Int?
            if self.ddqSafeOfIndex(index: bIndex, operation: .aig) {
                
                beforeObjc = self[bIndex]
                beforeIndex = bIndex
            }
            
            let lIndex = index + 1
            var lastObjc: Element?
            var lastIndex: Int?
            if self.ddqSafeOfIndex(index: lIndex, operation: .aig) {
                
                lastObjc = self[lIndex]
                lastIndex = lIndex
            }
            
            block(element, index, beforeObjc, beforeIndex, lastObjc, lastIndex)
        }
    }

    typealias DDQFilterBlock = (_ objc: Element, _ index: Int) -> Bool
    typealias DDQFilterLastBlock = (_ objc: Element, _ index: Int, _ lastObjc: Element?, _ lastIndex: Int?) -> Bool
    typealias DDQFilterBeforeBlock = (_ objc: Element, _ index: Int, _ beforeObjc: Element?, _ beforeIndex: Int?) -> Bool
    typealias DDQFilterBeforeAndLastBlock = (_ objc: Element, _ index: Int, _ beforeObjc: Element?, _ beforeIndex: Int?, _ lastObjc: Element?, _ lastIndex: Int?) -> Bool

    func ddqFilter(block: DDQFilterBlock) -> [Element] {
        return self.filter { (objc) -> Bool in
            
            let index = self.firstIndex(of: objc)!
            return block(objc, index)
        }
    }
    
    func ddqFilterWithLast(block: DDQFilterLastBlock) -> [Element] {
        return self.filter { (objc) -> Bool in
            
            let index = self.firstIndex(of: objc)!
            let lastIndex = index + 1
            if self.ddqSafeOfIndex(index: lastIndex, operation: .aig) {
                return block(objc, index, self[lastIndex], lastIndex)
            }
            
            return block(objc, index, nil, nil)
        }
    }
    
    func ddqFilterWithBefore(block: DDQFilterBeforeBlock) -> [Element] {
        return self.filter { (objc) -> Bool in
            
            let index = self.firstIndex(of: objc)!
            let beforeIndex = index - 1
            if self.ddqSafeOfIndex(index: beforeIndex, operation: .aig) {
                return block(objc, index, self[beforeIndex], beforeIndex)
            }
            
            return block(objc, index, nil, nil)
        }
    }

    func ddqFilterWithBeforeAndLast(block: DDQFilterBeforeAndLastBlock) -> [Element] {
        return self.filter { (objc) -> Bool in
            
            let index = self.firstIndex(of: objc)!
            
            let bIndex = index - 1
            var bObjc: Element?
            var beforeIndex: Int?
            if self.ddqSafeOfIndex(index: bIndex, operation: .aig) {
                
                beforeIndex = bIndex
                bObjc = self[bIndex]
            }
            
            let lIndex = index + 1
            var lObjc: Element?
            var lastIndex: Int?
            if self.ddqSafeOfIndex(index: lIndex, operation: .aig) {
                
                lastIndex = lIndex
                lObjc = self[lIndex]
            }
            
            return block(objc, index, bObjc, beforeIndex, lObjc, lastIndex)
        }
    }
}

public extension Array where Element: Comparable {
    func ddqSortedArray(ascending: Bool) -> [Element] {
        
        return self.sorted { (objc1, objc2) -> Bool in
            if ascending {
                return objc1 < objc2
            }
            
            return objc1 > objc2
        }
    }
}

public extension Array where Element == Int {
    func ddqIsContinue() -> Bool {
                
        let sortedArray = self.ddqSortedArray(ascending: true)
        let filterArray = sortedArray.ddqFilterWithLast { (objc, _, lastObjc, _) -> Bool in
            if let l = lastObjc {
                return l - objc == 1
            }
            
            return true
        }
        
        return sortedArray.count == filterArray.count
    }
}
