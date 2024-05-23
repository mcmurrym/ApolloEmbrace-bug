//
//  Network.swift
//  ApolloEmbrace
//
//  Created by Matt McMurry on 5/23/24.
//

import Foundation
import Apollo

class Network {

    static private(set) var shared = Network()

    private(set) lazy var apollo: ApolloClient = {
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let client = URLSessionClient()
        let provider = NetworkInterceptorProvider(store: store, client: client)
        let url = URL(string: "https://countries.trevorblades.com/")!

        let requestChainTransport = RequestChainNetworkTransport(
            interceptorProvider: provider,
            endpointURL: url
        )

        return ApolloClient(
            networkTransport: requestChainTransport,
            store: store
        )
    }()
}
