//
//  MemoryGame.swift
//  Assignment-2
//
//  Created by Artyom Danilov on 09.04.2023.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private var faceUpIndex: Int?
    private(set) var score = 0

    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let matchIndex = faceUpIndex {
                if cards[chosenIndex].content == cards[matchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[matchIndex].isMatched = true
                    score += 2
                } else if cards[chosenIndex].isSeen || cards[matchIndex].isSeen {
                    score -= 1
                }
                faceUpIndex = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                faceUpIndex = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }

    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }

    struct Card: Identifiable {
        var isFaceUp = false {
            willSet(newIsFaceUp) {
                if isFaceUp && !newIsFaceUp {
                    isSeen = true
                }
            }
        }
        var isMatched = false
        var isSeen = false
        var content: CardContent
        var id: Int
    }
}
