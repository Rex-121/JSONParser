//
//  JSONValidate.swift
//  JSONParser
//
//  Created by Tyrant on 2022/4/9.
//

import Foundation

///
public extension String {
    
    
    private var JSONReadingOptions: JSONSerialization.ReadingOptions {
        if #available(iOS 15.0, macOS 12.0, *) {
            return first == "[" ? [.json5Allowed] : [.topLevelDictionaryAssumed, .json5Allowed]
        } else {
            return [.fragmentsAllowed]
        }
    }
    
    ///
    var isValidateJSON: Result<JSON, Error> {
        
        if (isEmpty) { return .success(JSON("")) }
        
        do {
            
            let d = JSONDecoder()
            if #available(macOS 12.0, *) {
                d.allowsJSON5 = true
            } else {
                // Fallback on earlier versions
            }
            
            //            print("fasdf")
            let v = try d.decode(Decoding.self, from: data(using: .utf8)!)
            //
            print(v.value)
            //            let aa = JSONSerialization()
            
            let data = try JSONSerialization
                .jsonObject(with: data(using: .utf8)!,
                            options: JSONReadingOptions)
            
            return .success(JSON(data))
        }
        catch {
            print(error)
            return .failure(error)
        }
        
        
    }
    
}
