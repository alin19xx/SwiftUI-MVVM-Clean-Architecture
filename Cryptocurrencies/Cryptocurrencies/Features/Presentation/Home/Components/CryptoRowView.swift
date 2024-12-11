//
//  CryptoRowView.swift
//  Cryptocurrencies
//
//  Created by Alex Lin Segarra on 11/12/24.
//

import SwiftUI

struct CryptoRowView: View {
    
    @Binding var crypto: CryptoModel
    var onSelect: () -> Void
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            remoteAsyncImage
            VStack(alignment: .leading) {
                Text(crypto.name)
                    .font(.headline)
                Text(crypto.symbol)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            VStack(alignment: .trailing) {
                priceText
                percentChangeText
            }
            .frame(width: 80)
            favoriteButton
        }
    }
    
    @ViewBuilder
    private var remoteAsyncImage: some View {
        if let logoUrl = crypto.logoUrl, let url = URL(string: logoUrl) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                default:
                    placeholderImage(for: crypto.name)
                }
            }
        } else {
            placeholderImage(for: crypto.name)
        }
    }
    
    @ViewBuilder
    private var priceText: some View {
        let price = crypto.quotePriceUSD
        if price >= 1000 {
            Text("$\(price, specifier: "%.0f")")
        } else {
            Text("$\(price, specifier: "%.2f")")
        }
    }

    @ViewBuilder
    private var percentChangeText: some View {
        let percentChange = crypto.quotePercentChange1hUSD
        Text("(\(percentChange, specifier: "%+.2f")%)")
            .foregroundColor(percentChange > 0 ? .green : .red)
    }
    
    private var favoriteButton: some View {
        Button(action: {
            onSelect()
        }) {
            Image(systemName: crypto.isFavorite ? "star.fill" : "star")
                .foregroundColor(crypto.isFavorite ? .yellow : .gray)
        }
    }
    
    func placeholderImage(for name: String) -> some View {
        Text(String(name.prefix(1)))
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.white)
            .frame(width: 30, height: 30)
            .background(Circle().fill(Color.gray))
            .clipShape(Circle())
    }
}


#Preview {
    CryptoRowView(crypto: .constant(CryptoModel(crypto: CryptoDecodable(id: 12,
                                                                        name: "Ethereum",
                                                                        symbol: "ETH",
                                                                        logoUrl: nil,
                                                                        quote: ["USD": QuoteDecodable(price: 2000,
                                                                                                      percentChange1h: 0.5)]))), onSelect: {})
}