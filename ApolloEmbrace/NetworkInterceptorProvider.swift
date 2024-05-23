//
//  NetworkInterceptorProvider.swift
//  ApolloEmbrace
//
//  Created by Matt McMurry on 5/23/24.
//

import Foundation
import Apollo
import CountriesAPI

struct NetworkInterceptorProvider: InterceptorProvider {

    private let store: ApolloStore
    private let client: URLSessionClient

    init(store: ApolloStore,
         client: URLSessionClient) {
        self.store = store
        self.client = client
    }

    func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        return [
            CacheReadInterceptor(store: store),
            NetworkFetchInterceptor(client: client),
            ResponseCodeInterceptor(),
            JSONResponseParsingInterceptor(),
            AutomaticPersistedQueryInterceptor(),
            CacheWriteInterceptor(store: store)
        ]
    }
}
