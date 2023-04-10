//
//  Assignment_2App.swift
//  Assignment-2
//
//  Created by Artyom Danilov on 09.04.2023.
//

import SwiftUI

@main
struct Assignment_2App: App {
    let game = EmojiMemoryGame()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
