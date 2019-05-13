//: Please build the scheme 'RxSwiftPlayground' first
import RxSwift

example(of: "subscribe") {
  
  let observable = Observable.of(episodeIV, episodeV, episodeVI)
  
  observable.subscribe(onNext: { element in
    print(element)
  })
}

example(of: "empty") {
  
  let observable = Observable<Void>.empty()
  
  observable
    .subscribe(
      onNext: { element in
        print(element)
    },
      onCompleted: {
        print("Completed")
    }
  )
}

example(of: "never") {
  
  let observable = Observable<Any>.never()
  
  observable
    .subscribe(
      onNext: { element in
        print(element)
    },
      onCompleted: {
        print("Completed")
    }
  )
}

example(of: "dispose") {
  
  let mostPopular = Observable.of(episodeV, episodeIV, episodeVI)
  
  let subscription = mostPopular.subscribe { event in
    print(event)
  }
  
  subscription.dispose()
}

example(of: "DisposeBag") {
  
  let disposeBag = DisposeBag()
  
  Observable.of(episodeVII, episodeI, rogueOne)
    .subscribe {
      print($0)
    }
    .disposed(by: disposeBag)
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
