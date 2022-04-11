//
//  JSON.swift
//  JSONParser
//
//  Created by Tyrant on 2022/3/28.
//

import Foundation
import CloudKit
import SwiftUI

public struct JSON {
    
    public enum `Type`: String {
        case dictionary
        case array
        case single
    }
    
    var type: JSON.`Type` {
        JSON.FindType(data: data)
    }
    
    let key: String
    
    let data: Any
    
    let index: Int
    
    let contains: [JSON]
    
    public init(index: Int = -1, key: String = "", _ data: Any) {
        self.data = data
        self.key = key
        self.index = index
        
        switch JSON.FindType(data: data) {
        case .dictionary:
            
            let a = data as? Dictionary<String, Any> ?? Dictionary<String, Any>()
            
            contains = a.map { JSON(index: index + 1, key: $0, $1) }
            
        case .array:
            let a = data as? Array<Any> ?? []
            contains = a.map { JSON(index: index + 1, $0) }
            
        case .single:
            contains = []
        }
        
    }
    
    //    func allLineViews() -> [JSONKeyValue] {
    //        let dic = data as? Dictionary<String, Any> ?? [:]
    //        return dic.ToJSONKeyValue
    //    }
}


extension JSON: CustomDebugStringConvertible {
    
    static func FindType(data: Any) -> JSON.`Type` {
        switch data {
        case is Array<Any>:
            return .array
        case is Dictionary<String, Any>:
            return .dictionary
        default:
            return .single
        }
    }
    
    public func adf() {
        contains.forEach { v in
            print(v.debugDescription)
        }
    }
    
    var keyDescription: String {
        key.isEmpty ? "" : "\(key): "
    }
    
   public var debugDescription: String {
        
        switch type {
        case .single:
            return "\(index.TabString)\(keyDescription)\(data)"
        case .dictionary:
            return """
\(index.TabString)\(keyDescription)
\(index.TabString){
\(contains.map { $0.debugDescription }.joined(separator: "\n"))
\(index.TabString)}
"""
        case .array:
            return """
\(index.TabString)\(keyDescription)
\(index.TabString)[
\(contains.map { $0.debugDescription }.joined(separator: "\n"))
\(index.TabString)]
"""
        }
        
        
    }
    
}


extension Int {
    
    var TabString: String {
        return Array(repeating: "    ", count: self).joined()
    }
    
}
