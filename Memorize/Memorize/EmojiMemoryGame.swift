//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Artyom Danilov on 04.04.2023.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let emojis = [
        "🚂", "🚀", "🚁", "🚜", "🚗", "🚕", "🚙", "🚌", "🏎️", "🏍️",
        "✈️", "🛸", "🛳️", "⛵️"
    ]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
