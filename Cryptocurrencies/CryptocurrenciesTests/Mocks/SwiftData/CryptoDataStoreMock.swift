//
//  CryptoDataStoreMock.swift
//  CryptocurrenciesTests
//
//  Created by Alex Lin Segarra on 12/12/24.
//

import Foundation
@testable import Cryptocurrencies

@MainActor
class CryptoDataStoreMock: CryptoDataStoreProtocol {
    private var storedFavorites: [CryptoModel] = []

    func fetchFavCryptos() -> [CryptoModel] {
        return storedFavorites
    }

    func insertCrypto(_ crypto: CryptoModel) {
        storedFavorites.append(crypto)
    }

    func deleteCrypto(_ crypto: CryptoModel) {
        storedFavorites.removeAll { $0.id == crypto.id }
    }
}
