//
//  GetProductDetail.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import Foundation

class GetProductDetail: NSObject {
    private var productId: Int
    init(productId: Int) {
        self.productId = productId
    }
}

extension GetProductDetail: EndpointProvider {
    typealias Response = BaseDTO<ProductDetail>
    typealias Body = EmptyDTO
    typealias Failure = BaseDTO<[EmptyDTO]> // Body appears to be an empty array in case of failure
    typealias Query = EmptyDTO
    
    var endpoint: Endpoint<Body, Query> {
        return Endpoint(api: API(baseURL: .catalogAPI, path: ["v1", "product", "\(productId)"]),
                        method: .get,
                        path: [],
                        query: nil,
                        headers: .defaultHeaders,
                        body: nil)
    }
}
