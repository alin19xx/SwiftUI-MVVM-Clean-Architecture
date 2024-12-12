//
//  HomeView.swift
//  Cryptocurrencies
//
//  Created by Alex Lin Segarra on 11/12/24.
//

import SwiftUI

enum ListType: String {
    case all = "All Cryptocurrencies"
    case favorites = "Favorites"
}

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel.createDefault()
    @State private var selectedCrypto: CryptoModel?
    @State private var showDetail: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    List {
                        if !viewModel.favoriteCryptocurrencies.isEmpty {
                            contentListView(type: .favorites,
                                            data: $viewModel.favoriteCryptocurrencies)
                        }
                        contentListView(type: .all,
                                        data: $viewModel.cryptocurrencies)
                    }
                }
            }
            .navigationTitle("Cryptocurrencies")
            .task {
                await viewModel.loadCryptocurrencies()
            }
        }
        .sheet(item: $selectedCrypto) { crypto in
            DetailView(crypto: crypto)
                .presentationDetents([.fraction(0.85)])
        }
    }
    
    
    // MARK: - Accessory views
    
    @ViewBuilder
    private func contentListView(type: ListType, data: Binding<[CryptoModel]>) -> some View {
        Section(header: Text(type.rawValue)) {
            cryptoListSection(data: data)
        }
    }

    @ViewBuilder
    private func cryptoListSection(data: Binding<[CryptoModel]>) -> some View {
        ForEach(data.indices, id: \.self) { index in
            CryptoRowView(crypto: data[index], onSelect: {
                selectedCrypto = data[index].wrappedValue
            })
            .transition(.slide)
            .contextMenu {
                Button(action: {
                    withAnimation {
                        viewModel.toggleFavorite(crypto: data[index].wrappedValue) { }
                    }
                }) {
                    getFavoriteIcon(isFav: data[index].isFavorite.wrappedValue)
                }
            }
        }
    }
    
    @ViewBuilder
    private func getFavoriteIcon(isFav: Bool) -> some View {
        if isFav {
            Text("Unfavorite")
            Image(systemName: "star.fill")
        } else {
            Text("Favorite")
            Image(systemName: "star")
        }
    }
}

#Preview {
    HomeView()
}
