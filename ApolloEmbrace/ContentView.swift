//
//  ContentView.swift
//  ApolloEmbrace
//
//  Created by Matt McMurry on 5/23/24.
//

import SwiftUI
import CountriesAPI

struct Continent: Identifiable {
    var id: String { code }
    let code: String
}

struct ContentView: View {

    @State private var continents: [Continent] = []

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")

            if continents.isEmpty {
                ProgressView()
            } else {
                ForEach(continents) { continent in
                    Text(continent.code)
                }
            }
        }
        .padding()
        .task {
            do {
                #warning("when start is called, apollo requests will not complete. Comment out to see the request complete.")
                EmbraceController.start()
                let result = try await Network.shared.apollo.fetch(query: GetContinentsQuery())
                continents = result.continents.map { Continent(code: $0.code) }
            } catch {

            }
        }
    }
}

#Preview {
    ContentView()
}
