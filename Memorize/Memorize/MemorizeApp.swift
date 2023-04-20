//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Artyom Danilov on 27.03.2023.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
