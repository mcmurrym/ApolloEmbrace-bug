//
//  ApolloClient+Extension.swift
//  ApolloEmbrace
//
//  Created by Matt McMurry on 5/23/24.
//

import Foundation
import Apollo
import CountriesAPI

extension ApolloClient {
    enum UnknownError: Error {
        case unknown
    }

    @MainActor
    public func fetch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy = .fetchIgnoringCacheCompletely,
        contextIdentifier: UUID? = nil,
        queue: DispatchQueue = .main
    ) async throws -> Query.Data {
        return try await withCheckedThrowingContinuation { continuation in
            fetch(query: query, cachePolicy: cachePolicy, contextIdentifier: contextIdentifier, queue: queue) { result in
                switch result {
                    case .success(let value):
                        if let data = value.data {
                            continuation.resume(returning: data)
                        } else if let errors = value.errors, !errors.isEmpty {
                            continuation.resume(throwing: errors[0])
                            if errors.count > 1 {
                                print("Multiple errors in request: \(errors)")
                            }
                        } else {
                            continuation.resume(throwing: UnknownError.unknown)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: error)
                }
            }
        }
    }
}
