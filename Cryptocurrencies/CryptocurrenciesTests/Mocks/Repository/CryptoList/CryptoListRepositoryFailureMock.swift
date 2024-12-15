//
//  CryptoListRepositoryFailureMock.swift
//  CryptocurrenciesTests
//
//  Created by Alex Lin Segarra on 12/12/24.
//

import Foundation
@testable import Cryptocurrencies

class CryptoListRepositoryErrorMock: CryptoListRepositoryProtocol {
    
    let error: CryptoRepositoryError
    
    init(error: CryptoRepositoryError) {
        self.error = error
    }
    
    func fetchCryptoListings() async throws -> [CryptoDecodable] {
        throw error
    }
    
    func fetchCryptoInfo(for ids: [Int]) async throws -> [String: CryptoDetailsDecodable] {
        throw error
    }
}
