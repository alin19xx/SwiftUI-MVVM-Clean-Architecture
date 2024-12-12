//
//  CryptoListUsecase.swift
//  Cryptocurrencies
//
//  Created by Alex Lin Segarra on 11/12/24.
//

import Foundation

protocol CryptoListUseCaseProtocol {
    func execute() async throws -> [CryptoModel]
}

class CryptoListUseCase: CryptoListUseCaseProtocol {
    private let repository: CryptoListRepositoryProtocol

    init(repository: CryptoListRepositoryProtocol = CryptoListRepository()) {
        self.repository = repository
    }

    func execute() async throws -> [CryptoModel] {
        let listings = try await repository.fetchCryptoListings()
        let details = try await repository.fetchCryptoInfo(for: listings.map { $0.id })
        
        return listings.map { crypto in
            let detail = details[String(crypto.id)]
            let intermediate = CryptoEntity(crypto: crypto, details: detail)
            return CryptoModel(from: intermediate)
        }
    }
}
