//
//  CryptoListUseCaseTest.swift
//  CryptocurrenciesTests
//
//  Created by Alex Lin Segarra on 12/12/24.
//

import Testing
@testable import Cryptocurrencies
import Foundation

@Suite("Cryptocurrencies Listing")
struct CryptoListUseCaseTests {
    
    struct TestError: Error, CustomStringConvertible {
        let message: String
        var description: String { message }
        
        init(_ message: String) {
            self.message = message
        }
    }
    
    init() { }
    
    @Test
    func testFetchCryptoListingsSuccess() async throws {
        /// GIVEN
        let mockRepository = CryptoListRepositorySuccessMock()
        let useCase = CryptoListUseCase(repository: mockRepository)
        
        /// WHEN
        let result = try await useCase.execute()
        
        /// THEN
        #expect(result.count == 2)
        #expect(result.first?.name == "Bitcoin")
        #expect(result.last?.name == "Ethereum")
    }
    
    @Test
    func testFetchCryptoDetailsSuccess() async throws {
        /// GIVEN
        let mockRepository = CryptoListRepositorySuccessMock()
        let ids = [1, 1027]
        
        /// WHEN
        let details = try await mockRepository.fetchCryptoInfo(for: ids)
        
        /// THEN
        #expect(details["1"]?.name == "Bitcoin")
        #expect(details["1"]?.urls?.website?.first == "https://bitcoin.org/")
        #expect(details["1027"]?.name == "Ethereum")
        #expect(details["1027"]?.urls?.website?.first == "https://www.ethereum.org/")
    }
    
    
    @Test
    func testFetchCryptoListingsFailure() async throws {
        // GIVEN
        let mockRepository = CryptoListRepositoryErrorMock(
                    error: .networkError(URLError(.notConnectedToInternet))
                )
        let useCase = CryptoListUseCase(repository: mockRepository)
        
        // WHEN - THEN
        do {
            _ = try await useCase.execute()
            throw TestError("Expected an error to be thrown, but no error was thrown.")
        } catch let error as CryptoRepositoryError {
            switch error {
            case .networkError(let urlError):
                #expect(urlError.code == .notConnectedToInternet)
            default:
                throw TestError("Unexpected error case: \(error.localizedDescription)")
            }
        } catch {
            throw TestError("Unexpected error type: \(error)")
        }
    }
    
    /// Caso de error: Fallo al obtener detalles
    @Test
    func testFetchCryptoInfoFailure() async throws {
        // GIVEN
        let mockRepository = CryptoListRepositoryErrorMock(
                    error: .decodingError(DecodingError.dataCorrupted(
                        .init(codingPath: [], debugDescription: "Mock decoding error")
                    )))
        let useCase = CryptoListUseCase(repository: mockRepository)
        
        // WHEN - THEN
        do {
            _ = try await useCase.execute()
            throw TestError("Expected an error to be thrown, but no error was thrown.")
        } catch let error as CryptoRepositoryError {
            switch error {
            case .decodingError(let decodingError):
                if case .dataCorrupted(let context) = decodingError {
                    #expect(context.debugDescription == "Mock decoding error")
                } else {
                    throw TestError("Unexpected decoding error: \(decodingError.localizedDescription)")
                }
            default:
                throw TestError("Unexpected error case: \(error.localizedDescription)")
            }
        } catch {
            throw TestError("Unexpected error type: \(error)")
        }
    }
}
