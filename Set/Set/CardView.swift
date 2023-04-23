//
//  CardView.swift
//  Set
//
//  Created by Artyom Danilov on 23.04.2023.
//

import SwiftUI

struct CardView: View {
    let card: SetGame.Card
    let isSelected: Bool
    let formsASet: Bool?
    
    var body: some View {
        ZStack {
            let cornerRadius: CGFloat = 10
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(isSelected ? Color(red: 1.0, green: 0.95, blue: 0.75) : .white)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(
                            formsASet == true ? .green : formsASet == false ? .red : .black,
                            lineWidth: 2
                        )
                )
            
            VStack {
                ForEach(0..<card.number.rawValue, id:\.self) { _ in
                    symbol
                        .foregroundColor(color)
                        .aspectRatio(3/1, contentMode: .fit)
                        .padding(.horizontal, 8)
                }
            }
        }
    }
    
    private var symbol: some View {
        Group {
            let opacity: CGFloat = 0.4
            let lineWidth: CGFloat = 2
            
            switch card.shape {
            case .squiggle:
                let shape = Rectangle()
                switch card.shading {
                case .outlined:
                    shape.stroke(lineWidth: lineWidth)
                case .striped:
                    shape.opacity(opacity)
                case .solid:
                    shape
                }
            case .oval:
                let shape = RoundedRectangle(cornerRadius: 50)
                switch card.shading {
                case .outlined:
                    shape.stroke(lineWidth: lineWidth)
                case .striped:
                    shape.opacity(opacity)
                case .solid:
                    shape
                }
            case .diamond:
                let shape = Diamond()
                switch card.shading {
                case .outlined:
                    shape.stroke(lineWidth: lineWidth)
                case .striped:
                    shape.opacity(opacity)
                case .solid:
                    shape
                }
            }
        }
    }
    
    private var color: Color {
        switch card.color {
        case .red:
            return Color.red
        case .green:
            return Color.green
        case .blue:
            return Color.blue
        }
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let topPoint = CGPoint(x: rect.midX, y: rect.minY)
        let rightPoint = CGPoint(x: rect.maxX, y: rect.midY)
        let bottomPoint = CGPoint(x: rect.midX, y: rect.maxY)
        let leftPoint = CGPoint(x: rect.minX, y: rect.midY)
        
        path.move(to: topPoint)
        path.addLine(to: rightPoint)
        path.addLine(to: bottomPoint)
        path.addLine(to: leftPoint)
        path.addLine(to: topPoint)
        
        return path
    }
}

struct CardView_Previews: PreviewProvider {
    static let game = SetGameViewModel()
    
    static var previews: some View {
        let card = game.tableCards.first!
        CardView(card: card, isSelected: false, formsASet: false)
            .frame(width: 250, height: 400)
    }
}
