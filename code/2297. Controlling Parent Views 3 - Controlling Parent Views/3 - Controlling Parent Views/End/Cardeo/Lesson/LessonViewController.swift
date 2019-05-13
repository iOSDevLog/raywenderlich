/// Copyright (c) 2018 Razeware LLC
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

import UIKit

class LessonViewController: UIViewController {
  @IBOutlet var cardSuperview: CardSuperview! {
    didSet {
      cardSuperview.handleFlip = { [unowned self] _ in self.breakStreak() }
    }
  }
  
  @IBOutlet var multipleChoiceSuperview: UIView! 
  
  var cards: [Card]!
  
  override func viewDidLoad() {
    for view: UIView in [cardSuperview, multipleChoiceSuperview] {
      view.isExclusiveTouch = true
    }
    
    pickNewCard()
  }
  
  func pickNewCard() {
    let correctCard = cards.randomElement()!
    
    let imagesView =
      Bundle.main
      .loadNibNamed("\(LessonImagesView.self)", owner: nil)![0]
      as! LessonImagesView
    imagesView.cards = cards
    imagesView.correctCard = correctCard
    imagesView.delegate = self
    imagesView.assignCardsToControls()
    multipleChoiceSuperview.addSubview(imagesView, constrainedTo: multipleChoiceSuperview)
    
    cardSuperview.setCard(correctCard, side: .front, flip: false)
  }
  
  func breakStreak() {
    removeMultipleChoiceView()
    pickNewCard()
  }
  
  func animateOut(
    view: UIView, delay: TimeInterval = 0,
    handleCompletion: ( () -> Void)? = nil
  ) {
    UIView.animate(
      withDuration: 0.25,
      delay: delay,
      animations: {
        view.alpha = 0
        view.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
      }
    ) {
      [ handleCompletion = handleCompletion ?? { view.isHidden = true } ]
      _ in handleCompletion()
    }
  }
  
  func removeMultipleChoiceView() {
    let multipleChoiceView = multipleChoiceSuperview.subviews[0]
    animateOut(view: multipleChoiceView, handleCompletion: multipleChoiceView.removeFromSuperview)
  }
}

extension LessonViewController: LessonImagesViewDelegate {
  func handleCardControlTapped(correct: Bool) {
    if correct {
      
    }
    else {
      cardSuperview.flipCard()
      breakStreak()
    }
  }
}
