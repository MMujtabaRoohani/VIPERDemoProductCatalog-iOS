//
//  GetProductsList.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import Foundation

class GetProductsList: NSObject {
    private var requestObject: Body?
    private var queries: Query
    
    init(queries: Query) {
        self.queries = queries
    }
}

extension GetProductsList: EndpointProvider {
    typealias Response = BaseDTO<GetProductsListResponseBody>
    typealias Body = EmptyDTO
    typealias Failure = BaseDTO<[EmptyDTO]> // Body appears to be an empty array in case of failure
    typealias Query = ProductListQuery
    
    var endpoint: Endpoint<Body, Query> {
        return Endpoint(api: API(baseURL: .catalogAPI, path: ["v1", "products"]),
                        method: .get,
                        path: [],
                        query: queries,
                        headers: .defaultHeaders,
                        body: requestObject)
    }
}
