//
//  SetGameModel.swift
//  Set
//
//  Created by Artyom Danilov on 15.04.2023.
//

import Foundation

struct SetGame {
    enum Number: Int, CaseIterable {
        case one = 1, two, three
    }
    
    enum Shape: CaseIterable {
        case diamond, squiggle, oval
    }
    
    enum Shading: CaseIterable {
        case solid, striped, open
    }
    
    enum Color: CaseIterable {
        case red, green, blue
    }
    
    struct Card: Identifiable, Equatable, Hashable {
        let number: Number
        let shape: Shape
        let shading: Shading
        let color: Color
        let id: Int
    }
    
    private(set) var deckCards: [Card]
    private(set) var tableCards: [Card]
    private(set) var selectedCards: [Card] = []
    private(set) var setsFound: [[Card]] = []
    private(set) var currentSelectionFormsASet: Bool?
    
    init() {
        deckCards = []
        tableCards = []
        
        var id = 0
        for number in Number.allCases {
            for shape in Shape.allCases {
                for shading in Shading.allCases {
                    for color in Color.allCases {
                        deckCards.append(
                            Card(
                                number: number,
                                shape: shape,
                                shading: shading,
                                color: color,
                                id: id
                            )
                        )
                        id += 1
                    }
                }
            }
        }
        
        let initialNumberOfCards = 12
        
        repeat {
            deckCards.shuffle()
        } while !SetGame.setExists(in: Array(deckCards.suffix(initialNumberOfCards)))
        
        dealCards(howMany: initialNumberOfCards)
    }
    
    private mutating func dealCards(howMany numberOfCards: Int) {
        for _ in 0..<min(numberOfCards, deckCards.count) {
            tableCards.append(deckCards.removeLast())
        }
    }
        
    mutating func dealThreeCards() {
        if let currentSelectionFormsASet {
            if currentSelectionFormsASet {
                for card in setsFound.last! {
                    let index = tableCards.firstIndex { $0 == card }!
                    tableCards[index] = deckCards.removeLast()
                }
                selectedCards = []
                self.currentSelectionFormsASet = nil
                return
            }
        }
        dealCards(howMany: 3)
    }

    mutating func select(_ card: Card) {
        if let currentSelectionFormsASet {
            var selectedCardPartOfSet = false
            
            if currentSelectionFormsASet {
                if deckCards.isEmpty {
                    for card in setsFound.last! {
                        tableCards.removeAll { $0 == card }
                    }
                } else {
                    for card in setsFound.last! {
                        let index = tableCards.firstIndex { $0 == card }!
                        tableCards[index] = deckCards.removeLast()
                    }
                }
                selectedCardPartOfSet = selectedCards.contains(card)
            }
            
            selectedCards = []
            self.currentSelectionFormsASet = nil
            
            if selectedCardPartOfSet {
                return
            }
        }
        
        if selectedCards.contains(card) {
            selectedCards.removeAll { $0 == card }
            return
        }
        
        if selectedCards.count < 2 {
            selectedCards.append(card)
            return
        }
        
        selectedCards.append(card)
        
        if SetGame.isValidSet(cards: selectedCards) {
            setsFound.append(selectedCards)
            currentSelectionFormsASet = true
        } else {
            currentSelectionFormsASet = false
        }
    }

    static private func isValidSet(cards: [Card]) -> Bool {
        let numberSet = Set(cards.map { $0.number })
        let shapeSet = Set(cards.map { $0.shape })
        let shadingSet = Set(cards.map { $0.shading })
        let colorSet = Set(cards.map { $0.color })
        
        return (numberSet.count == 1 || numberSet.count == 3) &&
        (shapeSet.count == 1 || shapeSet.count == 3) &&
        (shadingSet.count == 1 || shadingSet.count == 3) &&
        (colorSet.count == 1 || colorSet.count == 3)
    }
    
    static private func setExists(in cards: [Card]) -> Bool {
        for card1 in cards {
            for  card2 in cards {
                if card2 == card1 {
                    continue
                }
                for card3 in cards {
                    if card3 == card2 || card3 == card1 {
                        continue
                    }
                    if SetGame.isValidSet(cards: [card1, card2, card3]) {
                        return true
                    }
                }
            }
        }
        return false
    }
        
    mutating func findSet() {
        for card1 in tableCards {
            for  card2 in tableCards {
                if card2 == card1 {
                    continue
                }
                for card3 in tableCards {
                    if card3 == card2 || card3 == card1 {
                        continue
                    }
                    if SetGame.isValidSet(cards: [card1, card2, card3]) {
                        // if pressed when three cards are selected that don't form a set
                        if currentSelectionFormsASet == false {
                            currentSelectionFormsASet = nil
                        }
                        selectedCards = [card1, card2]
                        select(card3)
                        return
                    }
                }
            }
        }
    }
    
    var atLeastOneSetExists: Bool {
        SetGame.setExists(in: tableCards)
    }
}
