//: Please build the scheme 'RxSwiftPlayground' first
import RxSwift

example(of: "PublishSubject") {
  
  let quotes = PublishSubject<String>()
  
  quotes.onNext(itsNotMyFault)
  
  let subscriptionOne = quotes
    .subscribe {
      print(label: "1)", event: $0)
  }
  
  quotes.on(.next(doOrDoNot))
  
  let subscriptionTwo = quotes
    .subscribe {
      print(label: "2)", event: $0)
  }
  
  quotes.onNext(lackOfFaith)
  
  subscriptionOne.dispose()
  
  quotes.onNext(eyesCanDeceive)
  
  quotes.onCompleted()
  
  let subscriptionThree = quotes
    .subscribe {
      print("3)", $0)
  }
  
  quotes.onNext(stayOnTarget)
  
  subscriptionTwo.dispose()
  subscriptionThree.dispose()
}

/*:
 Copyright (c) 2014-2018 Razeware LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
