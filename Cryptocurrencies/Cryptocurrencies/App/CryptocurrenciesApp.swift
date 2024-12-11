//
//  CryptocurrenciesApp.swift
//  Cryptocurrencies
//
//  Created by Alex Lin Segarra on 11/12/24.
//

import SwiftUI
import SwiftData

@main
struct CryptocurrenciesApp: App {

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(GlobalModelContainer.shared)
    }
}
