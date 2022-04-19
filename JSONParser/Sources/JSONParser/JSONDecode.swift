
import Foundation

protocol SingleValueProtocol {
    
}

struct EmptyValue: Decodable, SingleValueProtocol {
    
}

struct SingleValue<T: Decodable>: Decodable, SingleValueProtocol {
    let value: T
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
        
        if let double = try? container.decode(Double.self) {
            v = SingleValue(value: double)
            return
        }
        
        if let decimal = try? container.decode(Decimal.self) {
            v = SingleValue(value: decimal)
            return
        }
        
        v = EmptyValue()
    }
}



public struct Decoding: Decodable {
    
    public let value: `Type`
    
    public enum `Type` {
        
        case array(Array<Decodable>)
        case dictionary(Dictionary<String, Decodable>)
        case signle(SingleValueProtocol)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let dic = try? container.decode(Dictionary<String, Decoding>.self) {
            value = .dictionary(dic)
        }
        else if let arr = try? container.decode(Array<Decoding>.self) {
            value = .array(arr)
        }
        else {
            value = .signle(try container.decode(SignleValueParse.self).v)
        }
    }
    
}
