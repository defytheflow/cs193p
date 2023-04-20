//
//  ContentView.swift
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
                    // .padding(.horizontal, 20)
                Text("Cards in deck: \(game.numberOfCardsInDeck)")
                    // .padding(.horizontal, 20)
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
                Button {
                    game.startNewGame()
                } label: {
                    Text("New Game")
                }
                 .padding(.horizontal, 30)
                
                Button {
                    game.dealThreeCards()
                } label: {
                    Text("Deal 3 Cards")
                }
                .padding(.horizontal, 30)
                .disabled(game.numberOfCardsInDeck == 0)
                
                Button {
                    game.findSet()
                } label: {
                    Text("Find Set")
                }
                .padding(.horizontal, 30)
                .disabled(!game.atLeastOneSetExists)
            }
        }
    }
}

struct CardView: View {
    let card: SetGame.Card
    let isSelected: Bool
    let formsASet: Bool?
    
    var body: some View {
        ZStack {
            let cornerRadius: CGFloat = 10
            let selectedColor = Color(red: 1.0, green: 0.95, blue: 0.75)
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(isSelected ? selectedColor : .white)
                .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        formsASet == true ? .green : formsASet == false ? .red : .black,
                        lineWidth: 2))
            
            let numberOfShapes = card.number.rawValue
            VStack {
                ForEach(1...numberOfShapes, id: \.self) { _ in
                    shape
                        .foregroundColor(color)
                        .padding(.horizontal, 6)
                }
            }
        }
    }
    
    private var shape: some View {
        ZStack {
            let aspectRatio: CGFloat = 3/1
            let opacity: CGFloat = 0.4
            let lineWidth: CGFloat = 2
            
            switch card.shape {
            case .squiggle:
                let shape = Rectangle()
                switch card.shading {
                case .open:
                    shape.stroke(lineWidth: lineWidth).aspectRatio(aspectRatio, contentMode: .fit)
                case .striped:
                    shape.opacity(opacity).aspectRatio(aspectRatio, contentMode: .fit)
                case .solid:
                    shape.aspectRatio(aspectRatio, contentMode: .fit)
                }
            case .oval:
                let shape = RoundedRectangle(cornerRadius: 50)
                switch card.shading {
                case .open:
                    shape.stroke(lineWidth: lineWidth).aspectRatio(aspectRatio, contentMode: .fit)
                case .striped:
                    shape.opacity(opacity).aspectRatio(aspectRatio, contentMode: .fit)
                case .solid:
                    shape.aspectRatio(aspectRatio, contentMode: .fit)
                }
            case .diamond:
                let shape = Diamond()
                switch card.shading {
                case .open:
                    shape.stroke(lineWidth: lineWidth).aspectRatio(aspectRatio, contentMode: .fit)
                case .striped:
                    shape.opacity(opacity).aspectRatio(aspectRatio, contentMode: .fit)
                case .solid:
                    shape.aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
    private var color: Color {
        switch card.color {
        case .red:
            return .red
        case .green:
            return .green
        case .blue:
            return .blue
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(game: SetGameViewModel())
    }
}
