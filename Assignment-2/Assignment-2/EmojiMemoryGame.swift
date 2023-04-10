//
//  EmojiMemoryGame.swift
//  Assignment-2
//
//  Created by Artyom Danilov on 09.04.2023.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let availableThemes = [
        Theme(
            name: "Vehicles",
            emojis: ["🚂", "🚀", "🚁", "🚜", "🚗", "🚕", "🚙", "🚌", "🏎️", "🏍️", "✈️", "🛸", "🛳️", "⛵️"],
            cardColor: "red",
            numberOfPairsOfCards: .count(10)),
        Theme(
            name: "Animals",
            emojis: ["🐱", "🐶", "🐵", "🐮", "🦁", "🐹", "🐨", "🐧", "🐷", "🐺"],
            cardColor: "yellow",
            numberOfPairsOfCards: .random),
        Theme(
            name: "Sports",
            emojis: ["⚽", "🏀", "🎾", "🏐", "🏓", "🥊", "🎳", "⚾"],
            cardColor: "blue"),
        Theme(
            name: "Halloween",
            emojis: ["🎃", "💀", "👻", "👽", "👹", "🤡", "👺", "🦇", "🕸", "🕷"],
            cardColor: "orange"),
        Theme(
            name: "Christmas",
            emojis: ["⛄", "🎁", "🎅", "🎄", "❄️ "],
            cardColor: "purple"),
        Theme(
            name: "Food",
            emojis: ["🍔", "🍟", "🍓", "🥑", "🍇",  "🍑", "🍌"],
            cardColor: "green"),
        Theme(
            name: "Flowers",
            emojis: ["🌼", "🌹", "🌷", "🌻", "🌺"],
            cardColor: "green"),
    ]

    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
            theme.emojis[pairIndex]
        }
    }

    private var currentTheme = availableThemes.randomElement()!
    @Published private var model: MemoryGame<String>

    init() {
        model = EmojiMemoryGame.createMemoryGame(theme: currentTheme)
    }

    var themeName: String {
        return currentTheme.name
    }

    var themeColor: Color {
        switch currentTheme.cardColor {
        case "red":
            return .red
        case "yellow":
            return .yellow
        case "blue":
            return .blue
        case "orange":
            return .orange
        case "purple":
            return .purple
        case "green":
            return .green
        default:
            // We could return a default color here, but ...
            fatalError("Unable to interpret theme's color")
        }
    }

    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }

    var score: Int {
        return model.score
    }

    // MARK: - Intent(s)

    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }

    func startNewGame() {
        var newTheme: Theme
        repeat {
            newTheme = EmojiMemoryGame.availableThemes.randomElement()!
        } while newTheme == currentTheme
        currentTheme = newTheme;
        model = EmojiMemoryGame.createMemoryGame(theme: newTheme)
    }
}
