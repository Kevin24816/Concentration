//
//  Model.swift
//  Concentration
//
//  Created by Kevin Li on 12/23/17.
//  Copyright © 2017 Kevin Li. All rights reserved.
//

import Foundation

class GameModel {
    
    // Index of the first card showing its face
    var firstCardShown: Int?

    // Array of all the card objects
    var cards = [Card]()
    
    // The number of card matches that have been made
    var numMatches = 0
    
    // number of card flips made
    var flipCount = 0
    
    // Indicator if whether the game has ended
    var hasEnded = false
    
    // Carries out the action of choosing a card.
    // If it's the first card, flip up; if second, check if there's a match
    func chooseCard(at index: Int) {
        if cards[index].isMatched == true {
            return
        }
        
        // check if match
        if let matchIndex = firstCardShown, matchIndex != index {
            if cards[matchIndex].id == cards[index].id {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
                numMatches += 1
            }
            cards[index].isFaceUp = true
            firstCardShown = nil
        } else {
            // flip all other cards down
            for i in cards.indices {
                cards[i].isFaceUp = false
            }
            // flip chosen card up and save card
            cards[index].isFaceUp = true
            firstCardShown = index
            checkLast2Cards()
        }
        
        flipCount += 1
    }
    
    func checkLast2Cards() {
        if firstCardShown == nil {
            return
        }
        
        // if there is only one pair left, flip those up and match them
        if numMatches == cards.count / 2 - 1 {
            for i in cards.indices {
                if (cards[i].isMatched == false) {
                    cards[i].isMatched = true
                    cards[i].isFaceUp = true
                }
            }
            numMatches += 1
            hasEnded = true
        }
    }
    
    // Creates the card objects matching the number of pairs of cards specified
    init(numCardPairs: Int, faceChoices: [String]) {
        var choices = faceChoices
        let numCards = min(numCardPairs, faceChoices.count)
        
        for _ in 1...numCards {
            let randomIndex = Int(arc4random_uniform((UInt32(choices.count))))
            let emoji = choices.remove(at: randomIndex)
            let card = Card(face: emoji) // insert emoji
            cards += [card, card]
        }
        
        var shuffledCards = [Card]()
        for _ in 0..<cards.count {
            let randomIndex = Int(arc4random_uniform((UInt32(cards.count))))
            let card = cards.remove(at: randomIndex)
            shuffledCards += [card]
        }
        
        cards = shuffledCards
    }
    
}
