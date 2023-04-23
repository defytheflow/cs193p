//
//  SetGame.swift
//  Set
//
//  Created by Artyom Danilov on 15.04.2023.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    @Published private var model = SetGame()
    
    var atLeastOneSetExists: Bool {
        model.atLeastOneSetExists
    }
    
    var numberOfSetsFound: Int {
        model.foundSets.count
    }
    
    var numberOfCardsInDeck: Int {
        model.deck.numberOfCards
    }
    
    var tableCards: [SetGame.Card] {
        model.tableCards
    }
    
    var selectedCards: [SetGame.Card] {
        model.selectedCards
    }
    
    var currentSelectionFormsASet: Bool? {
        switch model.state {
        case .selectCard:
            return nil
        case .match:
            return true
        case .noMatch:
            return false
        }
    }
    
    func select(_ card: SetGame.Card) {
        model.select(card)
    }
    
    func dealThreeCards() {
        model.dealThreeCards()
    }
    
    func startNewGame() {
        model = SetGame()
    }
    
    func findSet() {
        model.findSet()
    }
}
