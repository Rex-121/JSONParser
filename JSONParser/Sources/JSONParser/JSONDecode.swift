
import Foundation

public protocol SingleValueProtocol: CustomDebugStringConvertible {
    
    /// 用于`Debug`，请勿在其他环境下使用
    func debugInConsole() -> String
    
}


extension SingleValueProtocol {
    public func debugInConsole() -> String { debugDescription }
}

/// 解析不了的`JSON` `Value`
struct EmptyValue: Decodable, SingleValueProtocol {
    var debugDescription: String { "nil" }
}

struct SingleValue<T: Decodable>: Decodable, SingleValueProtocol {
    let value: T
    var debugDescription: String { "\(value)" }
}

public struct SignleValueParse: Decodable {
    
    let v: SingleValueProtocol
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        
        if let string = try? container.decode(String.self) {
            v = SingleValue(value: string)
            return
        }
        
        if let int = try? container.decode(Int.self) {
            v = SingleValue(value: int)
            return
        }
        
        
        if let decimal = try? container.decode(Decimal.self) {
            v = SingleValue(value: decimal)
            return
        }
        
        
        if let double = try? container.decode(Double.self) {
            v = SingleValue(value: double)
            return
        }
        
        v = EmptyValue()
    }
}



public struct Decoding: Decodable, SingleValueProtocol {
    
    public let value: `Type`
    
    /// 类型
    public enum `Type` {
        
        /// 数组
        case array(SingleValueProtocol)
        
        /// 字典
        case dictionary(SingleValueProtocol)
        
        /// 字面量
        case signle(SingleValueProtocol)
        
    }
    
   
    
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let dic = try? container.decode([String: Decoding].self) {
            value = .dictionary(dic)
        }
        else if let arr = try? container.decode([Decoding].self) {
            value = .array(arr)
        }
        else {
            value = .signle(try container.decode(SignleValueParse.self).v)
        }
    }
    
}

extension Decoding: CustomDebugStringConvertible {
    public var debugDescription: String { value.debugDescription }
}


extension Decoding.`Type`: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        switch self {
        case .dictionary(let dic): return "{ \n \(dic.debugInConsole()) \n}"
        case .array(let array): return "[ \(array.debugInConsole()) ]"
        case .signle(let v): return v.debugDescription
        }
    }
    
    
    func indexed(v: Int) -> JSONIndexable {
        
        JSONIndexable(index: 0, value: self)
    }
}

extension Dictionary: SingleValueProtocol where Value: SingleValueProtocol {
    
    public func debugInConsole() -> String where Value: SingleValueProtocol {
        self.map { "\($0): \($1.debugDescription)" }.joined(separator: "\n")
    }
    
}

extension Array: SingleValueProtocol where Element: SingleValueProtocol {
    
    public func debugInConsole() -> String where Element: SingleValueProtocol {
        self.map { "\($0.debugDescription)" }.joined(separator: ", ")
    }
    
}
