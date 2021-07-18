//
//  DDQFileManager.swift
//  BJHeadline
//
//  Created by MyNameDDQ on 2021/1/29.
//

import Foundation

open class DDQFileManager: NSObject {
    
    static let DDQSaveDefaultdDirectoryName: String = "com.saveDefault"
    
    private let _sysFileManager: FileManager = FileManager.default
    private var _directoryPath: String!
    private var _folders: [String] = Array()
    
    public convenience init(directory: String?) {
        
        self.init()
        if directory == nil {
            
            let cache = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
            _directoryPath = cache?.appendingFormat("/%@", DDQFileManager.DDQSaveDefaultdDirectoryName)
        
        } else {
            _directoryPath = directory!
        }
        
        if !_sysFileManager.fileExists(atPath: _directoryPath) {
            try? _sysFileManager.createDirectory(at: URL(fileURLWithPath: _directoryPath), withIntermediateDirectories: false, attributes: nil)
        } else {
            guard let enumerator = _sysFileManager.enumerator(atPath: _directoryPath) else {
                return
            }
            
            while let element = enumerator.nextObject() {
                
                NSLog("%@", String(describing: element))
                if element is String {
                    self._folders.ddqAppend(element: element as? String)
                }
            }
        }
    }
    
    open func ddqCreatFile(namespace: String) -> Bool {
        if self._folders.contains(namespace) {
            return true
        }
        
        let path = _handlePath(namespace: namespace)
        var success = true
        if !_sysFileManager.fileExists(atPath: path) {
            success = _sysFileManager.createFile(atPath: path, contents: nil, attributes: nil)
        }
        
        if success {
            self._folders.ddqAppend(element: namespace)
        }
        return success
    }
    
    open func ddqFilePath(namespace: String) -> String? {
        if !self._folders.contains(namespace) {
            return nil
        }
        
        return _handlePath(namespace: namespace)
    }
    
    open func ddqWriteFile(namespace: String, data: Data) {
        if self._folders.contains(namespace) {
            guard let originPath = ddqFilePath(namespace: namespace) else {
                return
            }
            
            guard (try? _sysFileManager.removeItem(atPath: originPath)) != nil else {
                return
            }
                
            _sysFileManager.createFile(atPath: originPath, contents: data, attributes: nil)
            return
        }
        
        _sysFileManager.createFile(atPath: _handlePath(namespace: namespace), contents: data, attributes: nil)
    }
    
    open func ddqGetContent(namespace: String) -> Data? {
        if !self._folders.contains(namespace) {
            return nil
        }
        
        let path = _handlePath(namespace: namespace)
        return try? Data(contentsOf: URL(fileURLWithPath: path))
    }
    
    private func _handlePath(namespace: String) -> String {
        return _directoryPath.appendingFormat("/%@", namespace)
    }
}
