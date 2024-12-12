//
//  DetailView.swift
//  Cryptocurrencies
//
//  Created by Alex Lin Segarra on 11/12/24.
//

import SwiftUI

struct DetailView: View {
    let crypto: CryptoModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    cryptoImage
                    cryptoName
                    Spacer()
                }
                description
                marketInformation
            }
            .padding(.all, 20)
        }
        .navigationTitle(crypto.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    // MARK: - Accessory Views
    
    var cryptoImage: some View {
        AsyncImage(url: URL(string: crypto.logoUrl ?? "")) { image in
            image.resizable()
                .scaledToFit()
                .clipped()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 64, height: 64)
    }
    
    var cryptoName: some View {
        VStack(alignment: .leading) {
            Text(crypto.name)
                .font(.title)
                .bold()
            Text(crypto.symbol)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    var description: some View {
        VStack(alignment: .leading) {
            Text("Description")
                .font(.headline)
            Text(crypto.desc ?? "")
                .font(.body)
        }
    }
    
    var marketInformation: some View {
        VStack(alignment: .leading) {
            Text("Market Information")
                .font(.headline)
            VStack(alignment: .leading, spacing: 8) {
                Text("Price: $\(crypto.price, specifier: "%.2f")")
                Text("Market Cap: $\(crypto.marketCap, specifier: "%.2f")")
                Text("24h Volume: $\(crypto.volume24h, specifier: "%.2f")")
                Text("24h Volume Change: \(crypto.volumeChange24h, specifier: "%.2f")%")
                Text("1h Change: \(crypto.percentChange1h, specifier: "%.2f")%")
                Text("24h Change: \(crypto.percentChange24h, specifier: "%.2f")%")
                Text("7d Change: \(crypto.percentChange7d, specifier: "%.2f")%")
            }
        }
    }
}

#Preview {
    DetailView(crypto: CryptoModel(from: CryptoEntity(crypto: CryptoDecodable(id: 0, 
                                                                              name: "Bitcoin",
                                                                              symbol: "BTC",
                                                                              quote: [:]))))
}
