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
        await viewModel.toggleFavorite(crypto: cryptoToFavorite)

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
        await viewModel.toggleFavorite(crypto: favoriteCrypto)

        // THEN
        await #expect(viewModel.cryptocurrencies.count == 1)
        await #expect(store.fetchFavCryptos().count == 2)
    }
}
