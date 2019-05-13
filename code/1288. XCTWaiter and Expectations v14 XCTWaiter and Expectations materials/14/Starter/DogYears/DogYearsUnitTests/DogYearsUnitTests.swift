/// Copyright (c) 2017 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import XCTest
@testable import DogYears

class DogYearsUnitTests: XCTestCase {
    let calc = Calculator()
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAdd() {
		let result = calc.evaluate(op: "+", arg1: 2.0, arg2: 9.0)
		XCTAssert(result == 11.0, "Calculator add operation failed")
    }
	
	func testSubtract() {
		let result = calc.evaluate(op: "-", arg1: 9.0, arg2: 2.0)
		XCTAssert(result == 7.0, "Calculator subtraction operation failed")
	}
	
	func testDivide() {
		let result = calc.evaluate(op: "/", arg1: 9.0, arg2: 3.0)
		XCTAssert(result == 3.0, "Calculator division operation failed")
	}
	
	func testMultiply() {
		let result = calc.evaluate(op: "*", arg1: 4.0, arg2: 2.0)
		XCTAssert(result == 8.0, "Calculator multiplication operation failed")
	}

	func testResult() {
		let res1 = calc.evaluate(op: "+", arg1: 2.0, arg2: 2.0)
		let res2 = calc.result
		XCTAssert(res1 == res2, "Calculator displayed result does not match calculation result")
	}
	
	func testClear() {
		_ = calc.evaluate(op: "+", arg1: 2.0, arg2: 2.0)
		calc.clear()
		let result = calc.result
		XCTAssert(result == 0.0, "Calculator clear operation failed")
	}
 
  func testInfoLoading() {
    
    let sb = UIStoryboard(name: "Main", bundle: nil)
    XCTAssertNotNil(sb, "Could not instantiate storyboard for Info View content loading")
    guard let vc = sb.instantiateViewController(withIdentifier: "InformationView") as? InfoViewController else {
      XCTAssert(false, "Could not instaniate view controller for Info View content loading")
      return
    }
    _ = vc.view
    let txt1 = vc.txtInfo.text
    vc.loadContent()
    let txt2 = vc.txtInfo.text
    XCTAssert(txt1 != txt2, "Loading content for Info View did not change text")
    
    
    
  }
 
 
 
	
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
