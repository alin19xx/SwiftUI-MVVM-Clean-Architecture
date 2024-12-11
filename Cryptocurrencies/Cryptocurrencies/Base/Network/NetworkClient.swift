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
            throw NetworkError.decodingError(decodingError)
        } catch let urlError as URLError {
            throw NetworkError.networkError(urlError)
        } catch {
            throw error
        }
    }
}
