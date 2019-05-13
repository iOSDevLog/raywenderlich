//: Please build the scheme 'RxSwiftPlayground' first
import RxSwift

example(of: "map") {
  
  let disposeBag = DisposeBag()
    
  Observable.from(episodes)
    .map {
      var components = $0.components(separatedBy: " ")
      let number = NSNumber(value: try! components[1].romanNumeralIntValue())
      let numberString = String(describing: number)
      components[1] =  numberString
      return components.joined(separator: " ")
    }
    .subscribe(onNext: {
      print($0)
    })
    .disposed(by: disposeBag)
}

example(of: "flatMap") {
  
  let disposeBag = DisposeBag()
  
  let ryan = Jedi(rank: BehaviorSubject(value: .youngling))
  let charlotte = Jedi(rank: BehaviorSubject(value: .youngling))
  
  let student = PublishSubject<Jedi>()
  
  student
    .flatMap {
      $0.rank
    }
    .subscribe(onNext: {
      print($0.rawValue)
    })
    .disposed(by: disposeBag)
  
  student.onNext(ryan)
  
  ryan.rank.onNext(.padawan)
  
  student.onNext(charlotte)
  
  ryan.rank.onNext(.jediKnight)
  
  charlotte.rank.onNext(.jediMaster)
}

example(of: "flatMapLatest") {
  
  let disposeBag = DisposeBag()
  
  let ryan = Jedi(rank: BehaviorSubject(value: .youngling))
  let charlotte = Jedi(rank: BehaviorSubject(value: .youngling))
  
  let student = PublishSubject<Jedi>()
  
  student
    .flatMapLatest {
      $0.rank
    }
    .subscribe(onNext: {
      print($0.rawValue)
    })
    .disposed(by: disposeBag)
  
  student.onNext(ryan)
  
  ryan.rank.onNext(.padawan)
  
  student.onNext(charlotte)
  
  ryan.rank.onNext(.jediKnight)
  
  charlotte.rank.onNext(.jediMaster)
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
