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
    @Environment(\.modelContext) var modelContext
    
    @StateObject private var viewModel = HomeViewModel.createDefault()
    
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
                    .toolbar {
                        EditButton()
                    }
                }
            }
            .navigationTitle("Cryptocurrencies")
            .task {
                await viewModel.loadCryptocurrencies()
            }
        }
    }
    
    // MARK: - Accessory views
    
    @ViewBuilder
    private func contentListView(type: ListType, data: Binding<[CryptoModel]>) -> some View {
        Section(header: Text(type.rawValue)) {
            switch type {
            case .all:
                ForEach(data.indices, id: \.self) { index in
                    CryptoRowView(crypto: data[index], onSelect: {
                        
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
            case .favorites:
                ForEach(data.indices, id: \.self) { index in
                    CryptoRowView(crypto: data[index], onSelect: {
                        
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
                .onMove(perform: viewModel.moveFavorites)
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
        .modelContainer(for: [
            CryptoModel.self
        ], inMemory: true)
}
