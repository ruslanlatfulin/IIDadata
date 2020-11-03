//
//  AddressSuggestionQuery.swift
//  IIDadata
//
//  Created by Yachin Ilya on 12.05.2020.
//

import Foundation

///AddressSuggestionQuery represents an serializable object used to perform certain queries.
public class AddressSuggestionPostalUnitQuery: Encodable, DadataQueryProtocol{
    let query: String
    let queryType: AddressQueryType
    public var resultsCount: Int? = 10
    public var language: QueryResultLanguage?
    public var upperScaleLimit: ScaleBound?
    public var lowerScaleLimit: ScaleBound?
    
    public convenience init(_ query: String){
        self.init(query, ofType: .address)
    }

    public required init(_ query: String, ofType type: AddressQueryType){
        self.query = query
        self.queryType = type
    }
    
    enum CodingKeys: String, CodingKey {
        case query
        case resultsCount = "count"
        case language
        case upperScaleLimit = "from_bound"
        case lowerScaleLimit = "to_bound"
    }
    
    func toJSON() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    ///Returns an API endpoint for different request types:
    ///`address` — "suggest/address"
    ///`fiasOnly` — "suggest/fias"
    ///`findByID` — "findById/address"
    ///`postalUnit` —  "suggest/postal_unit"
    func queryEndpoint() -> String { return queryType.rawValue }
}

