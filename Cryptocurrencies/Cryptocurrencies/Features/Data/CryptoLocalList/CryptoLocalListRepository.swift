//
//  CryptoLocalListRepository.swift
//  Cryptocurrencies
//
//  Created by Alex Lin Segarra on 11/12/24.
//

import Foundation
import SwiftData

@MainActor
protocol CryptoLocalListRepositoryProtocol {
    func fetchCryptoFavList() -> [CryptoModel]
    func addCrypto(_ cryptocurrency: CryptoModel)
    func removeCrypto(_ cryptocurrency: CryptoModel)
}

@MainActor
class CryptoLocalListRepository: CryptoLocalListRepositoryProtocol {
    private let persistenceManager: PersistenceManagerProtocol
    
    init(persistenceManager: PersistenceManagerProtocol) {
        self.persistenceManager = persistenceManager
    }
    
    convenience init() {
        let defaultManager = SwiftDataPersistenceManager(modelContext: GlobalModelContainer.shared.mainContext)
        self.init(persistenceManager: defaultManager)
    }

    func fetchCryptoFavList() -> [CryptoModel] {
        do {
            return try persistenceManager.fetch(FetchDescriptor<CryptoModel>())
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
            return []
        }
    }

    func addCrypto(_ cryptocurrency: CryptoModel) {
        persistenceManager.insert(cryptocurrency)
        save()
    }

    func removeCrypto(_ cryptocurrency: CryptoModel) {
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
