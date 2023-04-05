//
//  ContentView.swift
//  Assignment-1
//
//  Created y Artyom Danilov on 27.03.2023.
//

import SwiftUI

struct EmojiTheme: Identifiable {
    var id: String { name }
    let name: String
    let image: String
    let emojis: [Character]
}

let vehicles = EmojiTheme(
    name: "Vehicles",
    image: "car",
    emojis: [
        "🚂", "🚀", "🚁", "🚜", "🚗", "🚕", "🚙", "🚌", "🏎️", "🏍️",
        "✈️", "🛸", "🛳️", "⛵️"])

let animals = EmojiTheme(
    name: "Animals",
    image: "pawprint",
    emojis: ["🐱", "🐶", "🐵", "🐮", "🦁", "🐹", "🐨", "🐧", "🐷", "🐺"])

let sports = EmojiTheme(
    name: "Sports",
    image: "figure.disc.sports",
    emojis: ["⚽", "🏀", "🎾", "🏐", "🏓", "🥊", "🎳", "⚾"])

let themes = [vehicles, animals, sports]
let defaultTheme = themes[0]
let minCardsCount = 4

struct ContentView: View {
    @State var selectedThemeId = defaultTheme.id {
        didSet {
            cardsIndices = selectedTheme.emojis.indices.map { $0 }.shuffled()
            cardsCount = Int.random(in: minCardsCount..<selectedTheme.emojis.count)
        }
    }
    @State var cardsIndices = defaultTheme.emojis.indices.map { $0 }.shuffled()
    @State var cardsCount = Int.random(in: minCardsCount..<defaultTheme.emojis.count)
    
    var selectedTheme: EmojiTheme {
        themes.first { $0.id == selectedThemeId }!
    }
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.semibold)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(cardsIndices.prefix(cardsCount), id: \.self) { idx in
                        CardView(content: String(selectedTheme.emojis[idx]))
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                ForEach(themes) { theme in
                    Button {
                        selectedThemeId = theme.id
                    } label: {
                        VStack {
                            Image(systemName: theme.image)
                                .padding(.bottom, 2)
                                .font(.largeTitle)
                            Text(theme.name)
                                .font(.callout)
                        }
                    }.padding(.horizontal)
                }
            }
            .padding()
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
