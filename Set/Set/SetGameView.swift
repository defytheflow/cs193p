//
//  SetGameView.swift
//  Set
//
//  Created by Artyom Danilov on 15.04.2023.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetGameViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Sets exist: \(game.atLeastOneSetExists ? "true" : "false")")
                Text("Sets found: \(game.numberOfSetsFound)")
                Text("Cards in deck: \(game.numberOfCardsInDeck)")
            }
            .padding(.top, 15)
            
            AspectVGrid(items: game.tableCards, aspectRatio: 2/3) { card in
                let isSelected = game.selectedCards.contains(card)
                let formsASet = isSelected ? game.currentSelectionFormsASet : nil
                
                CardView(card: card, isSelected: isSelected, formsASet: formsASet)
                    .padding(3)
                    .onTapGesture {
                        game.select(card)
                    }
            }
            .padding(10)
            
            HStack {
                Button("New Game", action: game.startNewGame)
                Spacer()
                Button("Deal 3 Cards", action: game.dealThreeCards)
                    .disabled(game.numberOfCardsInDeck == 0)
                Spacer()
                Button("Find Set", action: game.findSet)
                    .disabled(!game.atLeastOneSetExists)
            }
            .padding(.horizontal, 25)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(game: SetGameViewModel())
    }
}
