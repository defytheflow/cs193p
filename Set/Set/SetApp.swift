//
//  SetApp.swift
//  Set
//
//  Created by Artyom Danilov on 15.04.2023.
//

import SwiftUI

@main
struct SetApp: App {
    private let game = SetGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            SetGameView(game: game)
        }
    }
}
