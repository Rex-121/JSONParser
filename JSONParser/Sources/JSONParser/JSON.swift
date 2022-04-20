//
//  JSON.swift
//  JSONParser
//
//  Created by Tyrant on 2022/3/28.
//

import Foundation


public struct JSON {
    
    
    
    public enum `Type` {
        
        case dictionary
        
        case array
        
        case single(TrueValue)
        
        
        public enum TrueValue: CustomStringConvertible {
            case string(String)
            case int(Int)
            case double(Double)
            case `nil`
            
            public var description: String {
                switch self {
                case .string(let string):
                    return string
                case .int(let int):
                    return int.description
                case .double(let double):
                    return double.description
                case .nil:
                    return "null"
                }
            }
        }
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
}


extension JSON: CustomDebugStringConvertible {
    
    static func FindType(data: Any) -> JSON.`Type` {
        switch data {
        case is Array<Any>:
            return .array
        case is Dictionary<String, Any>:
            return .dictionary
        default:
            switch data {
            case is String:
                return .single(.string(data as! String))
            case is Double:
                return .single(.double(data as! Double))
            case is Int:
                return .single(.int(data as! Int))
            default:
                return .single(.nil)
            }
        }
    }
    
    public func inline() {
        //        return
        contains.forEach { print($0.debugDescription) }
    }
    
    var keyDescription: String {
        key.isEmpty ? "" : "\(key): "
    }
    
    public var debugDescription: String {
        
        switch type {
        case .single(let value):
            return "\(index.TabString)\(keyDescription)\(value)"
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
