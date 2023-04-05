//
//  MemoryGame.swift
//  Memorize
//
//  Created by Artyom Danilov on 04.04.2023.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private var faceUpIndex: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let matchIndex = faceUpIndex {
                if cards[chosenIndex].content == cards[matchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[matchIndex].isMatched = true
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
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id: Int
    }
}
