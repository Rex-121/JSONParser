//
//  JSON.swift
//  JSONParser
//
//  Created by Tyrant on 2022/3/28.
//

import Foundation


public struct JSON {
    
    
    /// `JSON`类型
    public enum `Type` {
        
        /// 字典
        case dictionary
        
        /// 数组
        case array
        
        /// 字面量
        case literal(LiteralValue)
        
        
        /// 字面量类型
        public enum LiteralValue: CustomDebugStringConvertible {
            
            ///  字符串
            case string(String)
            
            /// 整形
            case int(Int)
            
            /// 浮点数
            case double(Double)
            
            /// 空/无法解析的类型
            case `nil`
            
            public var debugDescription: String {
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
            
        case .literal:
            contains = []
        }
        
    }
}


extension JSON: CustomDebugStringConvertible {
    
    /// 分析`JSON Data`类型
    static func FindType(data: Any) -> JSON.`Type` {
        switch data {
        case is Array<Any>:
            return .array
        case is Dictionary<String, Any>:
            return .dictionary
        default:
            return .literal(ParseLiteralValue(by: data))
        }
    }
    
    /// 拆解字面量
    static func ParseLiteralValue(by data: Any) -> JSON.`Type`.LiteralValue {
        switch data {
        case is String:
            return .string(data as! String)
        case is Int:
            return .int(data as! Int)
        case is Double:
            return .double(data as! Double)
        default:
            return .nil
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
        case .literal(let value):
            return "\(index.TabString)\(keyDescription)\(value.debugDescription)"
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
