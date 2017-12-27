//
//  ViewController.swift
//  Concentration
//
//  Created by Kevin Li on 12/21/17.
//  Copyright © 2017 Kevin Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var cardsMatchedLabel: UILabel!
    
    @IBOutlet weak var endGameLabel: UILabel!
    
    var emojiChoices = ["🐸", "🐔", "🐶", "🐢", "🦉", "🐯", "🐃", "🦋", "🐙", "🦐"]
    
    lazy var game = GameModel(numCardPairs: cardButtons.count / 2, faceChoices: emojiChoices)
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var numCardsMatched = 0 {
        didSet {
            cardsMatchedLabel.text = "Cards matched: \(numCardsMatched)"
        }
    }
    
    // array of card buttons
    @IBOutlet var cardButtons: [UIButton]!
    
    // updates view based on cards in the model
    func updateView() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if (card.isFaceUp) {
                button.setTitle(card.face, for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0) : #colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1)
            }
        }
        numCardsMatched = game.numMatches
        flipCount = game.flipCount
        
        if (game.hasEnded) {
            // put up pop-up window to display final score
            let finalScore = 1000 * numCardsMatched / flipCount
            endGameLabel.text = "Congratulations! Final Score: \(finalScore)"
            flipCountLabel.isHidden = true
            cardsMatchedLabel.isHidden = true
            endGameLabel.isHidden = false
        }
    }
    
    // carries out actions when card button is touched
    @IBAction func touchCard(_ sender: UIButton) {
        game.chooseCard(at: cardButtons.index(of: sender)!)
        updateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        endGameLabel.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

