// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetContinentsQuery: GraphQLQuery {
  public static let operationName: String = "GetContinents"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetContinents { continents { __typename code } }"#
    ))

  public init() {}

  public struct Data: CountriesAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { CountriesAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("continents", [Continent].self),
    ] }

    public var continents: [Continent] { __data["continents"] }

    /// Continent
    ///
    /// Parent Type: `Continent`
    public struct Continent: CountriesAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { CountriesAPI.Objects.Continent }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("code", CountriesAPI.ID.self),
      ] }

      public var code: CountriesAPI.ID { __data["code"] }
    }
  }
}
