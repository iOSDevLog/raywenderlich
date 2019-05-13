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
  @IBOutlet var celebrationView: CelebrationView!
  
  @IBOutlet var streakBrokenView: UIView!
  @IBOutlet var streakBrokenLabel: UILabel!
  
  @IBOutlet var stackView: UIStackView!
  @IBOutlet var stackViewHeightConstraint: NSLayoutConstraint!
  
  @IBOutlet var cardSuperview: CardSuperview! {
    didSet {
      cardSuperview.handleFlip = { [unowned self] _ in self.breakStreak() }
    }
  }
  
  @IBOutlet var multipleChoiceSuperview: UIView! 
  
  var cards: [Card]!
  
  var streakCount = 0 {
    didSet {
      celebrationView.streakStackView.isHidden = streakCount < 2
      celebrationView.streakLabel.text = String(streakCount)
    }
  }

  override func viewDidLoad() {
    view.addSubview(
      celebrationView,
      constrainedTo: stackView, widthAnchorView: cardSuperview,
      multiplier: 1 / stackViewHeightConstraint.multiplier
    )
    view.addSubview(streakBrokenView, constrainedTo: multipleChoiceSuperview)
    
    for view: UIView in [cardSuperview, multipleChoiceSuperview] {
      view.isExclusiveTouch = true
    }

    pickNewCard()
  }
  
  override func shouldPerformSegue(withIdentifier _: String, sender: Any?) -> Bool {
    return sender is Card
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender correctCard: Any?) {
    if let namesViewController = segue.destination as? LessonNamesViewController {
      namesViewController.cards = cards
      namesViewController.correctCard = (correctCard as! Card)
      namesViewController.delegate = self
    }
  }

  @IBAction func handleTryAgainTap() {
    pickNewCard()
    animateOut(view: streakBrokenView)
  }
  
  func pickNewCard() {
    let side = CardView.Side.allCases.randomElement()!
    let correctCard = cards.randomElement()!

    switch side {
    case .front:
      performSegue(withIdentifier: "NamesSegue", sender: correctCard)
    case .back:
      let imagesViewController = UIStoryboard(
        name: "\(LessonImagesViewController.self)",
        bundle: nil
        ).instantiateInitialViewController() as! LessonImagesViewController
      imagesViewController.cards = cards
      imagesViewController.correctCard = correctCard
      imagesViewController.delegate = self
      addChild(imagesViewController)
      multipleChoiceSuperview.addSubview(
        imagesViewController.view,
        constrainedTo: multipleChoiceSuperview
      )
      imagesViewController.didMove(toParent: self)
    }

    cardSuperview.setCard(correctCard, side: side, flip: true)
    cardSuperview.isUserInteractionEnabled = true
  }

  func breakStreak() {
    streakBrokenLabel.text = "\(streakCount)"
    streakCount = 0
    cardSuperview.isUserInteractionEnabled = false
    streakBrokenView.animateIn()
    removeMultipleChoiceView()
  }

  func animateOut(
    view: UIView, delay: TimeInterval = 0,
    handleCompletion: ( () -> Void )? = nil
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
    let childController = children.first { $0.view == multipleChoiceView }!
    animateOut(view: multipleChoiceView) {
      childController.removeFromParent()
      multipleChoiceView.removeFromSuperview()
    }
  }
}

extension LessonViewController: MultipleChoiceViewControllerDelegate {
  func handleCardControlTapped(correct: Bool) {
    if correct {
      streakCount += 1
      removeMultipleChoiceView()
      celebrationView.animateIn(handleCompletion: pickNewCard)
      animateOut(view: celebrationView, delay: 0.6)
    }
    else {
      cardSuperview.flipCard()
      breakStreak()
    }
  }
}
