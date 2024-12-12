//
//  CryptoDataStore.swift
//  Cryptocurrencies
//
//  Created by Alex Lin Segarra on 12/12/24.
//

import Foundation
import SwiftData

@MainActor
protocol CryptoDataStoreProtocol {
    func fetchFavCryptos() -> [CryptoModel]
    func insertCrypto(_ cryptocurrency: CryptoModel)
    func deleteCrypto(_ cryptocurrency: CryptoModel)
}

@MainActor
class CryptoDataStore: CryptoDataStoreProtocol {
    private let persistenceManager: PersistenceManagerProtocol
    
    init(persistenceManager: PersistenceManagerProtocol) {
        self.persistenceManager = persistenceManager
    }
    
    convenience init() {
        let defaultManager = SwiftDataPersistenceManager(modelContext: GlobalModelContainer.shared.mainContext)
        self.init(persistenceManager: defaultManager)
    }
    
    func fetchFavCryptos() -> [CryptoModel] {
        do {
            return try persistenceManager.fetch(FetchDescriptor<CryptoModel>())
        } catch {
            return []
        }
    }

    func insertCrypto(_ cryptocurrency: CryptoModel) {
        persistenceManager.insert(cryptocurrency)
        save()
    }

    func deleteCrypto(_ cryptocurrency: CryptoModel) {
        persistenceManager.delete(cryptocurrency)
        save()
    }
    
    private func save() {
        do {
            try persistenceManager.save()
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
}
