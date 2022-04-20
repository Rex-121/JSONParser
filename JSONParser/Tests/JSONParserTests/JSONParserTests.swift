import XCTest
@testable import JSONParser

final class JSONParserTests: XCTestCase {
    let dic2 = """
       {
            "out": {
                      "outarray": [
                      3, 2
                   ],
               "outvalue": 1,
               "outdic": {
                
               }
               
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
           value.inline()
           
           print("------")
           
           let value1 = try dic2.isValidateJSON.get()
           value1.inline()
       }
       
       func testArrayValidate() throws {
                   
           let value = try array.isValidateJSON.get()
//           value.inline()
           
       }
       
       
       func testEmptyString() throws {
                   
           let value = try "".isValidateJSON.get()
           
       }
       
       
       
       
       func testPerformanceExample() throws {
           // This is an example of a performance test case.
           self.measure {
               // Put the code you want to measure the time of here.
           }
       }
       
}
