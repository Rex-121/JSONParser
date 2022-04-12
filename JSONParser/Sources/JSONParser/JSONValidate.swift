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
