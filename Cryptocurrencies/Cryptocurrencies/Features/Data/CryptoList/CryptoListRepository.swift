//
//  CryptoListRepository.swift
//  Cryptocurrencies
//
//  Created by Alex Lin Segarra on 11/12/24.
//

import Foundation

protocol CryptoListRepositoryProtocol {
    func fetchCryptoListings() async throws -> [CryptoDecodable]
    func fetchCryptoInfo(for ids: [Int]) async throws -> [String: CryptoDetailsDecodable]
}

class CryptoListRepository: CryptoListRepositoryProtocol {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchCryptoListings() async throws -> [CryptoDecodable] {
        do {
            let request = APIRequest(
                baseURL: APIConfig.baseURL,
                path: APIConfig.listingsURL,
                queryItems: [
                    URLQueryItem(name: "CMC_PRO_API_KEY", value: APIConfig.apiKey),
                    URLQueryItem(name: "limit", value: "10")
                ]
            )
            
            let url = try request.url()
            let response: CryptoListDecodable = try await networkClient.fetch(url: url)
            return response.data
        } catch {
            throw handleError(error)
        }
    }
    
    func fetchCryptoInfo(for ids: [Int]) async throws -> [String: CryptoDetailsDecodable] {
        do {
            let idsString = ids.map { "\($0)" }.joined(separator: ",")
            let request = APIRequest(
                baseURL: APIConfig.baseURL,
                path: APIConfig.infoURL,
                queryItems: [
                    URLQueryItem(name: "CMC_PRO_API_KEY", value: APIConfig.apiKey),
                    URLQueryItem(name: "id", value: idsString),
                    URLQueryItem(name: "aux", value: "logo,description,urls")
                ]
            )
            
            let url = try request.url()
            let detailsResponse: CryptoInfoResponse = try await networkClient.fetch(url: url)
            return detailsResponse.data
        } catch {
            throw handleError(error)
        }
    }
}


// MARK: - Private Methods

extension CryptoListRepository {
    
    private func handleError(_ error: Error) -> CryptoRepositoryError {
        if let urlError = error as? URLError {
            return .networkError(urlError)
        } else if let decodingError = error as? DecodingError {
            return .decodingError(decodingError)
        } else if let cryptoError = error as? CryptoRepositoryError {
            return cryptoError
        } else {
            return .unknownError(error)
        }
    }
}
