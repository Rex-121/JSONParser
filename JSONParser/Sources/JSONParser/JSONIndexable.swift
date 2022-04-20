//
//  File.swift
//  
//
//  Created by Tyrant on 2022/4/20.
//

import Foundation


struct JSONIndexable: SingleValueProtocol {
    
    var debugDescription: String {
        value.debugDescription
    }
    
    
    let index: Int
    
    let value: Decoding.`Type`
    
    
    func f(v: Int = 0) {
//        value.value
        var d = JSONIndexable(index: v, value: value)
    }
}
