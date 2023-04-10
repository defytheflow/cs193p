//
//  Theme.swift
//  Assignment-2
//
//  Created by Artyom Danilov on 09.04.2023.
//

import Foundation

struct Theme: Equatable {
    enum NumberOfCards {
        case all, random
        case count(Int)
    }
    
    let name: String
    private(set) var emojis: [String]
    let numberOfPairsOfCards: Int
    let cardColor: String

    init(name: String, emojis: [String], cardColor: String, numberOfPairsOfCards: NumberOfCards = .all) {
        let numberOfPairs: Int
        switch numberOfPairsOfCards {
        case .all:
            numberOfPairs = emojis.count
        case .random:
            numberOfPairs = Int.random(in: 4...emojis.count)
        case .count(let numberOfPairs_):
            numberOfPairs = numberOfPairs_
        }
        
        precondition(numberOfPairs > 0)
        precondition(emojis.count > 0)
        precondition(emojis.count == Set(emojis).count, "Every emoji must be unique")
        
        self.name = name
        self.emojis = emojis
        self.numberOfPairsOfCards = min(emojis.count, numberOfPairs)
        self.cardColor = cardColor
        
        if numberOfPairs < emojis.count {
            self.emojis.shuffle()
        }
    }
}
