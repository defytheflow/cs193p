//
//  SetGame.swift
//  Set
//
//  Created by Artyom Danilov on 15.04.2023.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    @Published private var model = SetGame()
    
    var atLeastOneSetExists: Bool { model.atLeastOneSetExists }
    var numberOfSetsFound: Int { model.setsFound.count }
    var numberOfCardsInDeck: Int { model.deckCards.count }
    var tableCards: [SetGame.Card] { model.tableCards }
    var selectedCards: [SetGame.Card] { model.selectedCards }
    var currentSelectionFormsASet: Bool? { model.currentSelectionFormsASet }
    
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
