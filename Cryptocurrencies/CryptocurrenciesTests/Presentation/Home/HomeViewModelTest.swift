//
//  HomeViewModelTest.swift
//  CryptocurrenciesTests
//
//  Created by Alex Lin Segarra on 12/12/24.
//

import Testing
import Foundation
@testable import Cryptocurrencies

@Suite("HomeViewModel Tests")
struct HomeViewModelTests {
    
    @Test
    func testLoadCryptocurrenciesSuccess() async throws {
        // GIVEN
        let useCase = CryptoListUseCaseSuccessMock()
        let store = await CryptoDataStoreMock()
        let viewModel = await HomeViewModel(cryptoUseCase: useCase, cryptoStore: store)
        
        // WHEN
        await viewModel.loadCryptocurrencies()
        
        // THEN
        await #expect(viewModel.isLoading == false)
        await #expect(viewModel.cryptocurrencies.count == 2)
        await #expect(viewModel.favoriteCryptocurrencies.isEmpty)
        await #expect(viewModel.cryptocurrencies.first?.name == "Bitcoin")
    }

    @Test
    func testLoadCryptocurrenciesWithFavorites() async throws {
        // GIVEN
        let useCase = CryptoListUseCaseSuccessMock()
        let store = await CryptoDataStoreMock()
        await store.insertCrypto(CryptoModelMock.makeMockBitcoin())
        let viewModel = await HomeViewModel(cryptoUseCase: useCase, cryptoStore: store)
        
        // WHEN
        await viewModel.loadCryptocurrencies()
        
        // THEN
        await #expect(viewModel.isLoading == false)
        await #expect(viewModel.cryptocurrencies.count == 2)
        await #expect(store.fetchFavCryptos().count == 1)
        await #expect(store.fetchFavCryptos().first?.name == "Bitcoin")
    }

    @Test
    func testLoadCryptocurrenciesFailure() async throws {
        // GIVEN
        let useCase = CryptoListUseCaseFailureMock(error: .invalidResponse)
        let store = await CryptoDataStoreMock()
        let viewModel = await HomeViewModel(cryptoUseCase: useCase, cryptoStore: store)
        
        // WHEN
        await viewModel.loadCryptocurrencies()
        
        // THEN
        await #expect(viewModel.isLoading == false)
        await #expect(viewModel.cryptocurrencies.isEmpty)
        await #expect(viewModel.favoriteCryptocurrencies.isEmpty)
    }

    @Test
    func testToggleFavoriteAddToFavorites() async throws {
        // GIVEN
        let useCase = CryptoListUseCaseSuccessMock()
        let store = await CryptoDataStoreMock()
        let viewModel = await HomeViewModel(cryptoUseCase: useCase, cryptoStore: store)
        await viewModel.loadCryptocurrencies()
        
        let cryptoToFavorite = await viewModel.cryptocurrencies.first!
        
        // WHEN
        await viewModel.toggleFavorite(crypto: cryptoToFavorite) {}

        // THEN
        await #expect(viewModel.favoriteCryptocurrencies.count == 1)
        await #expect(store.fetchFavCryptos().count == 1)
        await #expect(store.fetchFavCryptos().first?.id == cryptoToFavorite.id)
    }

    @Test
    func testToggleFavoriteRemoveFromFavorites() async throws {
        // GIVEN
        let useCase = CryptoListUseCaseSuccessMock()
        let store = await CryptoDataStoreMock()
        let viewModel = await HomeViewModel(cryptoUseCase: useCase, cryptoStore: store)
        
        let favoriteCrypto = CryptoModelMock.makeMockEthereum()
        await store.insertCrypto(favoriteCrypto)
        await viewModel.loadCryptocurrencies()
        
        // WHEN
        await viewModel.toggleFavorite(crypto: favoriteCrypto) {}

        // THEN
        await #expect(viewModel.cryptocurrencies.count == 1)
        await #expect(store.fetchFavCryptos().count == 2)
    }
    
    struct CryptoModelMock {
        static func makeMockBitcoin() -> CryptoModel {
            return CryptoModel(
                id: 1,
                name: "Bitcoin",
                symbol: "BTC",
                logoUrl: "https://bitcoin.org/logo.png",
                desc: "Bitcoin is a decentralized digital currency.",
                website: ["https://bitcoin.org"],
                technicalDoc: ["https://bitcoin.org/whitepaper.pdf"],
                explorer: ["https://blockchain.com/btc"],
                price: 45000.0,
                volume24h: 3000000000.0,
                volumeChange24h: 2.5,
                percentChange1h: 0.1,
                percentChange24h: -0.5,
                percentChange7d: 5.0,
                marketCap: 850000000000.0
            )
        }

        static func makeMockEthereum() -> CryptoModel {
            return CryptoModel(
                id: 1027,
                name: "Ethereum",
                symbol: "ETH",
                logoUrl: "https://ethereum.org/logo.png",
                desc: "Ethereum is a decentralized platform for smart contracts.",
                website: ["https://ethereum.org"],
                technicalDoc: ["https://ethereum.org/whitepaper.pdf"],
                explorer: ["https://etherscan.io"],
                price: 3000.0,
                volume24h: 1500000000.0,
                volumeChange24h: -1.2,
                percentChange1h: 0.0,
                percentChange24h: 1.5,
                percentChange7d: 10.0,
                marketCap: 350000000000.0
            )
        }

        static func makeMockList() -> [CryptoModel] {
            return [makeMockBitcoin(), makeMockEthereum()]
        }
    }
}
