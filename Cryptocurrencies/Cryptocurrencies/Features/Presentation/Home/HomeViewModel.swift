//
//  HomeViewModel.swift
//  Cryptocurrencies
//
//  Created by Alex Lin Segarra on 11/12/24.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var cryptocurrencies: [CryptoModel] = []
    @Published var favoriteCryptocurrencies: [CryptoModel] = []
    @Published var isLoading = false
    
    private let cryptoUseCase: CryptoListUseCaseProtocol
    private let cryptoStore: CryptoDataStoreProtocol
    
    private init(
        cryptoUseCase: CryptoListUseCaseProtocol,
        cryptoStore: CryptoDataStoreProtocol
    ) {
        self.cryptoUseCase = cryptoUseCase
        self.cryptoStore = cryptoStore
    }

    static func createDefault() -> HomeViewModel {
        let cryptoUseCase = CryptoListUseCase()
        let cryptoStore = CryptoDataStore()
        return HomeViewModel(cryptoUseCase: cryptoUseCase, cryptoStore: cryptoStore)
    }
    
    func loadCryptocurrencies() async {
        isLoading = true
        
        do {
            let cryptos = try await cryptoUseCase.execute()
            let savedCryptos = cryptoStore.fetchFavCryptos()
            
            let allCryptos = cryptos.map { crypto -> CryptoModel in
                if let savedCrypto = savedCryptos.first(where: { $0.id == crypto.id }) {
                    return savedCrypto
                } else {
                    return crypto
                }
            }
            
            self.cryptocurrencies = allCryptos.filter { !$0.isFavorite }
            self.favoriteCryptocurrencies = allCryptos.filter { $0.isFavorite }
            self.isLoading = false
        } catch {
            self.isLoading = false
        }
    }
    
    
    func toggleFavorite(crypto: CryptoModel, completion: @escaping () -> Void) {
        var updatedCrypto = crypto
        updatedCrypto.isFavorite.toggle()
        
        if updatedCrypto.isFavorite {
            cryptoStore.insertCrypto(updatedCrypto)
            
            if let index = cryptocurrencies.firstIndex(where: { $0.id == updatedCrypto.id }) {
                cryptocurrencies.remove(at: index)
                favoriteCryptocurrencies.append(updatedCrypto)
            }
        } else {
            cryptoStore.deleteCrypto(updatedCrypto)
            
            if let index = favoriteCryptocurrencies.firstIndex(where: { $0.id == updatedCrypto.id }) {
                favoriteCryptocurrencies.remove(at: index)
                cryptocurrencies.append(updatedCrypto)
                cryptocurrencies.sort { $0.name < $1.name }
            }
        }
        
        completion()
    }
    
    func moveFavorites(from source: IndexSet, to destination: Int) {
        favoriteCryptocurrencies.move(fromOffsets: source, toOffset: destination)
    }
}
