//: Please build the scheme 'RxSwiftPlayground' first
import RxSwift

example(of: "ignoreElements") {
  
  let disposeBag = DisposeBag()
  
  let cannedProjects = PublishSubject<String>()
  
  cannedProjects
    .ignoreElements()
    .subscribe {
      print($0)
    }
    .disposed(by: disposeBag)
  
  cannedProjects.onNext(landOfDroids)
  cannedProjects.onNext(wookieWorld)
  cannedProjects.onNext(detours)
  cannedProjects.onCompleted()
}

example(of: "elementAt") {
  
  let disposeBag = DisposeBag()
  
  let quotes = PublishSubject<String>()
  
  quotes
    .elementAt(2)
    .subscribe(onNext: {
      print($0)
    })
    .disposed(by: disposeBag)
  
  quotes.onNext(mayTheOdds)
  quotes.onNext(liveLongAndProsper)
  quotes.onNext(mayTheForce)
}

example(of: "filter") {
  
  let disposeBag = DisposeBag()
  
  Observable.from(tomatometerRatings)
    .filter { movie in
      movie.rating >= 90
    }
    .subscribe(onNext: {
      print($0)
    })
    .disposed(by: disposeBag)
  
}

example(of: "skipWhile") {
  
  let disposeBag = DisposeBag()
  
  Observable.from(tomatometerRatings)
    .skipWhile { movie in
      movie.rating < 90
    }
    .subscribe(onNext: {
      print($0)
    })
    .disposed(by: disposeBag)
}

example(of: "skipUntil") {
  
  let disposeBag = DisposeBag()
  
  let subject = PublishSubject<String>()
  let trigger = PublishSubject<Void>()
  
  subject
    .skipUntil(trigger)
    .subscribe(onNext: {
      print($0)
    })
    .disposed(by: disposeBag)
  
  subject.onNext(episodeI.title)
  subject.onNext(episodeII.title)
  subject.onNext(episodeIII.title)
  
  trigger.onNext(())
  
  subject.onNext(episodeIV.title)
}

example(of: "distinctUntilChanged") {
  
  let disposeBag = DisposeBag()
  
  Observable<Droid>.of(.R2D2, .C3PO, .C3PO, .R2D2)
    .distinctUntilChanged()
    .subscribe(onNext: {
      print($0)
    })
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
