///// Copyright (c) 2018 Razeware LLC
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
import SnapKit

class BoardViewController: UIViewController {
  
  @IBOutlet weak var board: BoardView!
  @IBOutlet weak var diceResult: UILabel!
  @IBOutlet weak var diceImage: UIImageView!
  @IBOutlet weak var diceButton: UIButton!
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  @IBOutlet weak var playAgain: UIButton!
  
  private var pieces: [PieceView] = []
  
  private let engine = GameEngine()
  
  // MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupDice()
    setupPieces()
    showHidePlayAgain(show: false)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    adjustForHiddenNumbers()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    print("Board square width is \(board.squareWidth)")
    
    engine.setupObstacles()
    addObstacleViewsToBoard()
    ensurePiecesOnTop()
  }
  
  
  // MARK: - Board
  
  func addObstacleViewsToBoard() {
    let right = addRightLeaningLadder(to: board)
    let left =  addLeftLeaningLadder(to: board)
    
    let top = addTopCenteredSnake(to: board)
    let bottomLeft = addBottomLeftSnake(to: board)
    let bottomRight = addBottomRightSnake(to: board)
    
    let obstacles = [right, left, top, bottomLeft, bottomRight]
    obstacles.forEach { $0.fade(to: .shown) }
  }
  
  func adjustForHiddenNumbers() {
    let one = board.square(row: 4, column: 4)
    let fourteen = board.square(row: 2, column: 1)
    let twenty = board.square(row: 1, column: 4)
    let twentyTwo = board.square(row: 0, column: 3)
    
    [one, fourteen, twenty, twentyTwo].forEach { $0?.flip(to: .facesRight) }
  }
  
  
  // MARK: - Snakes
  
  @discardableResult
  private func addTopCenteredSnake(to view: UIView) -> SnakeView {
    let snake = SnakeView.create(size: board.squareWidth * 2.2)
    view.addSubview(snake)
    
    snake.addTopAnchor(to: view, constant: -board.squareWidth / 2)
    snake.addCenterXAnchor(to: view)
    
    return snake
  }
  
  @discardableResult
  private func addBottomLeftSnake(to view: UIView) -> SnakeView {
    let snake = SnakeView.create(size: board.squareWidth * 2.5, color: .green)
    view.addSubview(snake)
    
    snake.addBottomAnchor(to: view)
    snake.addLeftAnchor(to: view, constant: board.squareWidth / 8)
    
    return snake
  }
  
  @discardableResult
  private func addBottomRightSnake(to view: UIView) -> SnakeView {
    let snake = SnakeView.create(size: board.squareWidth * 1.5, color: .purple, direction: .facesLeft)
    view.addSubview(snake)
    
    let inset = -board.squareWidth / 8
    snake.addBottomAnchor(to: view, constant: inset)
    snake.addRightAnchor(to: view, constant: inset)
    return snake
  }
  
  // MARK: - Ladders
  
  private func addRightLeaningLadder(to view: UIView) -> LadderView {
    let span = board.squareWidth * 2
    let ladder = LadderView.create(size: span, direction: .facesRight)
    view.addSubview(ladder)
    
    // SnapKit
    ladder.snp.makeConstraints { make in
      make.centerY.equalTo(view).offset(-board.squareWidth)
      make.right.equalTo(view)
    }
    
    return ladder
  }
  
  private func addLeftLeaningLadder(to view: UIView) -> LadderView {
    let ladder = LadderView.create(size: board.squareWidth * 1.8, rotation: 20, direction: .facesLeft)
    view.addSubview(ladder)
    
    // NSLayoutAnchor abstracted - see UIView+NSLayoutAnchor.swift
    ladder.addCenterYAnchor(to: view, constant:  -board.squareWidth / 3)
    ladder.addLeftAnchor(to: view)
    
    return ladder
  }
  
  // MARK: - Dice
  
  private func setupDice() {
    diceResult.alpha = Alpha.hidden.rawValue
  }
  
  @IBAction func rollDiceTapped(sender: UIButton) {
    let result = engine.generateDiceResult()
    print("A \(result) was rolled.")
    
    animateDiceResult(result: result) { [weak self] _ in
      guard
        let strong = self,
        let board = strong.board,
        let currentLocation = strong.currentPiece.currentLocation
      else { return }
      
      let currentPiece = strong.currentPiece
      
      // Calculate final location
      let updated = strong.engine.calculateFinalLocation(on: board, current: currentLocation, move: result)
      
      // Retrieve final square
      guard let square = board.square(at: updated) else { return }
      
      // Pre-emptively update location
      strong.currentPiece.currentLocation = updated
      
      // Check if an obstacle will be encountered at that square
      // If so, queue up a second animation.
      var completion: ((Bool) -> Swift.Void)?
      if let obstacle = strong.engine.obstacleEncountered(at: updated) {
        completion = { _ in
          let final = obstacle.end
          guard let square = strong.board.square(at: final) else { return }
          currentPiece.currentLocation = final
          strong.board.move(piece: currentPiece, to: square, animated: true)
        }
      }
      
      strong.board.move(piece: strong.currentPiece, to: square, animated: true, completion: completion)
      
      // Check if the game is finished
      guard let final = strong.currentPiece.currentLocation else { return }
      if final == strong.board.finishLocation {
        print("Winner!")
        
        strong.showHideDice(show: false)
        strong.showHidePlayAgain(show: true)
      }
        
      // Otherwise, next player gets a turn
      else {
        strong.changeTurns()
      }
    }
  }
  
  private func showHideDice(show: Bool) {
    diceButton.isUserInteractionEnabled = show
    diceImage.isHidden = !show
  }
  
  private func showHidePlayAgain(show: Bool) {
    playAgain.isUserInteractionEnabled = show
    playAgain.isHidden = !show
  }
  
  @IBAction private func playAgainTapped(sender: UIButton) {
    segmentedControl.selectedSegmentIndex = 0
    showHidePlayAgain(show: false)
    showHideDice(show: true)
    ensurePiecesOnTop()
  }
  
  private func changeTurns() {
    segmentedControl.toggle()
  }
  
  private func animateDiceResult(result: Int, completion: ((Bool) -> Swift.Void)? = nil) {
    let duration = AnimationDuration.standard.rawValue
    diceResult.text = "\(result)"
    
    UIView.animate(withDuration: duration, animations: { [weak self] in
      guard let strong = self else { return }
      strong.diceImage.alpha = Alpha.hidden.rawValue
      strong.diceResult.alpha = Alpha.shown.rawValue
      
    }, completion: { _ in
      UIView.animate(withDuration: duration, animations: { [weak self] in
        guard let strong = self else { return }
        strong.diceImage.alpha = Alpha.shown.rawValue
        strong.diceResult.alpha = Alpha.hidden.rawValue
      }, completion: completion)
    })
  }
  
  private func setupPieces() {
    let size = board.squareWidth * 0.6
    let playerOne = PieceView.create(size: size, image: #imageLiteral(resourceName: "player-one"))
    let playerTwo = PieceView.create(size: size, image: #imageLiteral(resourceName: "player-two"))
    pieces = [playerOne, playerTwo]
  }
  
  private func ensurePiecesOnTop() {
    guard
      let start = board.start,
      let playerOne = pieces.first,
      let playerTwo = pieces.last
    else { return }
    
    playerOne.currentLocation = board.startLocation
    playerTwo.currentLocation = board.startLocation
    
    board.move(piece: playerOne, to: start, animated: false)
    board.bringSubview(toFront: playerOne)
    
    board.move(piece: playerTwo, to: start, animated: false)
    board.bringSubview(toFront: playerTwo)
  }
  
  var currentPiece: PieceView {
    return pieces[segmentedControl.selectedSegmentIndex]
  }
  
  var otherPiece: PieceView {
    let index = abs(segmentedControl.selectedSegmentIndex - 1)
    return pieces[index]
  }
  
}
