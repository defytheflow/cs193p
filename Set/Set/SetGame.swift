//
//  SetGameModel.swift
//  Set
//
//  Created by Artyom Danilov on 15.04.2023.
//

import Foundation

struct SetGame {
    private(set) var deck = Deck()
    private(set) var tableCards: [Card] = []
    private(set) var selectedCards: [Card] = []
    private(set) var foundSets: [[Card]] = []
    private(set) var state: State = .selectCard
        
    var atLeastOneSetExists: Bool {
        SetGame.setExists(in: tableCards)
    }
    
    init() {
        dealCards(howMany: 12)
    }

    mutating func select(_ card: Card) {
        if state == .match || state == .noMatch {
            var selectedCardPartOfSet = false
            
            if state == .match {
                if deck.isEmpty {
                    for card in foundSets.last! {
                        tableCards.removeAll { $0 == card }
                    }
                } else {
                    replaceLastFoundSet()
                }
                selectedCardPartOfSet = selectedCards.contains(card)
            }
            
            selectedCards = []
            state = .selectCard
            
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
        
        if SetGame.isValidSet(selectedCards[0], selectedCards[1], selectedCards[2]) {
            foundSets.append(selectedCards)
            state = .match
        } else {
            state = .noMatch
        }
    }

    mutating func dealThreeCards() {
        if state == .match {
            replaceLastFoundSet()
            selectedCards = []
            state = .selectCard
        } else {
            dealCards(howMany: 3)
        }
    }
    
    mutating func findSet() {
        for card1 in tableCards {
            for card2 in tableCards {
                if card2 == card1 {
                    continue
                }
                for card3 in tableCards {
                    if card3 == card2 || card3 == card1 {
                        continue
                    }
                    if SetGame.isValidSet(card1, card2, card3) {
                        state = .selectCard
                        selectedCards = [card1, card2]
                        select(card3)
                        return
                    }
                }
            }
        }
    }
    
    private mutating func replaceLastFoundSet() {
        for card in foundSets.last! {
            let index = tableCards.firstIndex { $0 == card }!
            tableCards[index] = deck.drawCard()!
        }
    }
    
    private mutating func dealCards(howMany numberOfCards: Int) {
        for _ in 1...numberOfCards {
            if let card = deck.drawCard() {
                tableCards.append(card)
            } else {
                break
            }
        }
    }
    
    private static func isValidSet(_ first: Card, _ second: Card, _ third: Card) -> Bool {
        let cards = [first, second, third]
        return (
            Set(cards.map { $0.number }).count != 2 &&
            Set(cards.map { $0.shape }).count != 2 &&
            Set(cards.map { $0.shading }).count != 2 &&
            Set(cards.map { $0.color }).count != 2
        )
    }
    
    private static func setExists<T: Collection>(in cards: T) -> Bool where T.Element == Card {
        for card1 in cards {
            for card2 in cards {
                if card2 == card1 {
                    continue
                }
                for card3 in cards {
                    if card3 == card2 || card3 == card1 {
                        continue
                    }
                    if SetGame.isValidSet(card1, card2, card3) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    enum State {
        case selectCard, match, noMatch
    }
    
    enum Number: Int, CaseIterable {
        case one = 1, two, three
    }
    
    enum Shape: CaseIterable {
        case diamond, squiggle, oval
    }
    
    enum Shading: CaseIterable {
        case solid, striped, outlined
    }
    
    enum Color: CaseIterable {
        case red, green, blue
    }
     
    struct Card: Identifiable, Equatable, Hashable {
        let number: Number
        let shape: Shape
        let shading: Shading
        let color: Color
        let id = UUID()
    }
    
    struct Deck {
        private var cards: [Card] = []
        
        init() {
            for number in Number.allCases {
                for shape in Shape.allCases {
                    for shading in Shading.allCases {
                        for color in Color.allCases {
                            cards.append(Card(number: number, shape: shape, shading: shading, color: color))
                        }
                    }
                }
            }
            
            repeat {
                cards.shuffle()
            } while !SetGame.setExists(in: cards.suffix(12))
        }
        
        var isEmpty: Bool {
            cards.isEmpty
        }
        
        var numberOfCards: Int {
            cards.count
        }
        
        mutating func drawCard() -> Card? {
            cards.popLast()
        }
    }
}
