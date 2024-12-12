//
//  CryptoListUseCaseFailureMock.swift
//  CryptocurrenciesTests
//
//  Created by Alex Lin Segarra on 12/12/24.
//

import Foundation
@testable import Cryptocurrencies

class CryptoListUseCaseFailureMock: CryptoListUseCaseProtocol {
    private let error: CryptoRepositoryError
    
    init(error: CryptoRepositoryError) {
        self.error = error
    }
    
    func execute() async throws -> [CryptoModel] {
        throw error
    }
}
