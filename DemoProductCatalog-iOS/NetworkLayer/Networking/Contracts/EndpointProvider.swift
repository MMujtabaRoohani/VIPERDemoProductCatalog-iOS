//
//  EndpointProvider.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import Foundation

public protocol EndpointProvider {
    associatedtype Response: DTO
    associatedtype Query: DTO
    associatedtype Body: DTO
    associatedtype Failure: DTO
    
    var endpoint: Endpoint<Body, Query> { get }
}
