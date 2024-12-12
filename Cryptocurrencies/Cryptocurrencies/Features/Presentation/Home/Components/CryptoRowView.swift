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
        let price = crypto.price
        if price >= 1000 {
            Text("$\(price, specifier: "%.0f")")
        } else {
            Text("$\(price, specifier: "%.2f")")
        }
    }

    @ViewBuilder
    private var percentChangeText: some View {
        let percentChange = crypto.percentChange24h
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
    CryptoRowView(crypto: .constant(CryptoModel(
        id: 12,
        name: "Ethereum",
        symbol: "ETH",
        logoUrl: nil,
        desc: "Ethereum is a decentralized platform that enables smart contracts and decentralized applications (dApps).",
        website: ["https://ethereum.org"],
        technicalDoc: ["https://ethereum.org/en/whitepaper/"],
        explorer: ["https://etherscan.io"],
        price: 2000.0,
        volume24h: 1000000.0,
        volumeChange24h: 5.0,
        percentChange1h: 0.5,
        percentChange24h: 2.3,
        percentChange7d: 10.0,
        marketCap: 200000000.0,
        isFavorite: false
    )), onSelect: {})
}
