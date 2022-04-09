//
//  JSONParserTests.swift
//  JSONParserTests
//
//  Created by Tyrant on 2022/4/9.
//

import XCTest
@testable import JSONParser

class JSONParserTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    let dic2 = """
    {
         "out": {
            "outvalue": 1,
            "outdic": {
             
            },
            "outarray": [
            3, 2
         ]
         }
       }
    """
    
    let dictionary = """
   {
     // comments
     unquoted: 'and you can quote me on that',
     singleQuotes: 'I can use "double quotes" here',
     lineBreaks: "Look, Mom! \
   No \\n's!",
     hexadecimal: 0xdecaf,
     leadingDecimalPoint: .8675309, andTrailing: 8675309.,
     positiveSign: +1,
     out: {
        outvalue: 1,
        outdic: {
           value: { value1: [{ value2: 2 }, { value3: ['3', '2', '1'], value2: 2 }] }
        },
        outarray: [
        3, 2
     ]
     },
     trailingComma: 'in objects', andIn: ['arrays',],
     "backwardsCompatible": "with JSON",
   }
   """
    
    let array = """
   ['arrays',]
   """
    
    func testValidate() throws {
                
        let value = try dictionary.isValidateJSON.get()
//        XCTAssertTrue(value.type == .dictionary)
        value.adf()
        
        let value1 = try dic2.isValidateJSON.get()
        value1.adf()
    }
    
    func testArrayValidate() throws {
                
        let value = try array.isValidateJSON.get()
        value.adf()
        XCTAssertTrue(value.type == .array)
        
    }
    
    
    func testEmptyString() throws {
                
        let value = try "".isValidateJSON.get()
        XCTAssertTrue(value.type == .single)
        
    }
    
    
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
