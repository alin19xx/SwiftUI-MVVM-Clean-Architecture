//
//  NetworkClientMock.swift
//  CryptocurrenciesTests
//
//  Created by Alex Lin Segarra on 12/12/24.
//

import Foundation
@testable import Cryptocurrencies

class MockNetworkClient: NetworkClient {
    var mockData: Data?
    var mockError: Error?

     override func fetch<T: Decodable>(url: URL) async throws -> T {
        if let error = mockError {
            throw error
        }

        guard let data = mockData else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
