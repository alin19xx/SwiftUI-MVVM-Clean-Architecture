//
//  NetworkClient.swift
//  Cryptocurrencies
//
//  Created by Alex Lin Segarra on 11/12/24.
//

import Foundation

class NetworkClient {
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func fetch<T: Decodable>(url: URL) async throws -> T {
        do {
            let (data, _) = try await session.data(from: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch let decodingError as DecodingError {
            throw CryptoRepositoryError.decodingError(decodingError)
        } catch let urlError as URLError {
            throw CryptoRepositoryError.networkError(urlError)
        } catch {
            throw CryptoRepositoryError.unknownError(error)
        }
    }
}
