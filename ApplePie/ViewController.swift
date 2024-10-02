//
//  ViewController.swift
//  ApplePie
//
//  Created by Wesley Keetch on 9/24/24.
//

import UIKit

var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"]

let incorrectMovesAllowed = 7

class ViewController: UIViewController {

  @IBOutlet weak var treeImageView: UIImageView!

  @IBOutlet weak var correctWordLabel: UILabel!

  @IBOutlet weak var scoreLabel: UILabel!

  @IBOutlet var letterButtons: [UIButton]!

  @IBAction func letterButtonPressed(_ sender: UIButton) {
    sender.isEnabled = false
    let letterString = sender.configuration!.title!
    let letter = Character(letterString.lowercased())
    currentGame.playerGuessed(letter: letter)
    updateGameState()
  }

  // I acknowledge this is not proper convenient o have my letterButtonPressed function above my viewDidLoad but I don't want to fix it and have to redo the connections.

  override func viewDidLoad() {
    super.viewDidLoad()
    newRound()
  }

  var currentGame: Game!

  var totalWins = 0 {
    didSet {
      newRound()
    }
  }

  var totalLosses = 0 {
    didSet {
      newRound()
    }
  }

  func newRound() {
    if !listOfWords.isEmpty {
      let newWord = listOfWords.removeFirst()
      currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
      enableLetterButtons(true)
      UpdateUI()
    } else {
      enableLetterButtons(false)
    }
  }

  func enableLetterButtons(_ enable: Bool) {
    for button in letterButtons {
      button.isEnabled = enable
    }
  }
  func UpdateUI() {
    var letters = [String]()
    for letter in currentGame.formattedWord {
      letters.append(String(letter))
    }
    let wordWithSpacing = letters.joined(separator: " ")
    correctWordLabel.text = wordWithSpacing
    scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
    treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
  }

  func updateGameState() {
    if currentGame.incorrectMovesRemaining == 0 {
      totalLosses += 1
    } else if currentGame.word == currentGame.formattedWord {
      totalWins += 1
    } else {
      UpdateUI()
    }
  }
}
