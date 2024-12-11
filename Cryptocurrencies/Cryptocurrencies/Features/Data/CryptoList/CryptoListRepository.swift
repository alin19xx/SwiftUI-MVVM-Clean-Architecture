//
//  CryptoListRepository.swift
//  Cryptocurrencies
//
//  Created by Alex Lin Segarra on 11/12/24.
//

import Foundation

protocol CryptoListRepositoryProtocol {
    func fetchCryptocurrencies() async throws -> [CryptoDecodable]
}

class CryptoListRepository: CryptoListRepositoryProtocol {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchCryptocurrencies() async throws -> [CryptoDecodable] {
        var cryptos = try await fetchCryptoListings()
        try await fetchLogos(for: &cryptos)
        return cryptos
    }
}


// MARK: - Private methods

extension CryptoListRepository {
    
    private func fetchCryptoListings() async throws -> [CryptoDecodable] {
        let request = APIRequest(
            baseURL: APIConfig.baseURL,
            path: APIConfig.listingsURL,
            queryItems: [
                URLQueryItem(name: "CMC_PRO_API_KEY", value: APIConfig.apiKey),
                URLQueryItem(name: "limit", value: "10")
            ]
        )
        
        let url = try request.url()
        let response: CryptoResponse = try await networkClient.fetch(url: url)
        return response.data
    }
    
    private func fetchLogos(for cryptocurrencies: inout [CryptoDecodable]) async throws {
        let ids = cryptocurrencies.map { "\($0.id)" }
        let request = APIRequest(
            baseURL: APIConfig.baseURL,
            path: APIConfig.infoURL,
            queryItems: [
                URLQueryItem(name: "CMC_PRO_API_KEY", value: APIConfig.apiKey),
                URLQueryItem(name: "id", value: ids.joined(separator: ",")),
                URLQueryItem(name: "aux", value: "logo")
            ]
        )
        
        let url = try request.url()
        let detailsResponse: CryptoInfoResponse = try await networkClient.fetch(url: url)
        
        for (index, crypto) in cryptocurrencies.enumerated() {
            if let details = detailsResponse.data[String(crypto.id)], let logo = details.logo {
                cryptocurrencies[index].logoUrl = logo
            }
        }
    }
}
    
//    private func fetchCryptoListings() async throws -> [CryptoDecodable] {
//        guard var urlComponents = URLComponents(string: listingsURL) else {
//            throw URLError(.badURL)
//        }
//        urlComponents.queryItems = [
//            URLQueryItem(name: "CMC_PRO_API_KEY", value: apiKey),
//            URLQueryItem(name: "limit", value: "10")
//        ]
//        
//        guard let url = urlComponents.url else {
//            throw URLError(.badURL)
//        }
//        
//        let (data, _) = try await session.data(from: url)
//        let response = try JSONDecoder().decode(CryptoResponse.self, from: data)
//        return response.data
//    }
    
//    private func fetchLogos(for cryptocurrencies: inout [CryptoDecodable]) async throws {
//        let ids = cryptocurrencies.map { "\($0.id)" }
//        guard var urlComponents = URLComponents(string: infoURL) else {
//            throw URLError(.badURL)
//        }
//        urlComponents.queryItems = [
//            URLQueryItem(name: "CMC_PRO_API_KEY", value: apiKey),
//            URLQueryItem(name: "id", value: ids.joined(separator: ",")),
//            URLQueryItem(name: "aux", value: "logo")
//        ]
//        
//        guard let url = urlComponents.url else {
//            throw URLError(.badURL)
//        }
//        
//        let (data, _) = try await session.data(from: url)
//        let detailsResponse = try JSONDecoder().decode(CryptoInfoResponse.self, from: data)
//        
//        for (index, crypto) in cryptocurrencies.enumerated() {
//            if let details = detailsResponse.data[String(crypto.id)], let logo = details.logo {
//                cryptocurrencies[index].logoUrl = logo
//            }
//        }
//    }

