//
//  GlobalModelContainer.swift
//  Cryptocurrencies
//
//  Created by Alex Lin Segarra on 11/12/24.
//

import Foundation
import SwiftData

class GlobalModelContainer {
    static let shared: ModelContainer = {
        
        let schema = Schema([
            CryptoModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error.localizedDescription)")
        }
    }()
}
