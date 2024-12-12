//
//  CryptoListRepositorySuccessMock.swift
//  CryptocurrenciesTests
//
//  Created by Alex Lin Segarra on 12/12/24.
//

import Foundation
@testable import Cryptocurrencies

class CryptoListRepositorySuccessMock: CryptoListRepositoryProtocol {
    
    func fetchCryptoListings() async throws -> [CryptoDecodable] {
        let data = CryptoListMock.makeJsonMock()
        let decoder = JSONDecoder()
        return try decoder.decode(CryptoListDecodable.self, from: data).data
    }
    
    func fetchCryptoInfo(for ids: [Int]) async throws -> [String: CryptoDetailsDecodable] {
        let data = CryptoInfoMock.makeJsonMock()
        let decoder = JSONDecoder()
        return try decoder.decode([String: CryptoDetailsDecodable].self, from: data)
    }
}
