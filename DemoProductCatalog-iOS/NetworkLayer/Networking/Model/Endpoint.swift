//
//  Endpoint.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import Foundation

public struct Endpoint<Body: DTO, Query: DTO> {
    public let method: HTTPMethod
    private let path: [String]
    private let query: Query?
    private let timeout: TimeInterval?
    private let headers: [String: String]?
    private let body: Body?
    let api: API
    
    public init(api: API,
                method: HTTPMethod,
                path: [String],
                query: Query? = nil,
                headers: [String: String]? = nil,
                timeout: TimeInterval? = nil,
                body: Body? = nil) {
        
        self.api = api
        self.method = method
        self.path = path
        self.query = query
        self.timeout = timeout
        self.body = body
        self.headers = headers
    }
    
    private var url: URL {
        var components = URLComponents()
        components.scheme = api.baseURL.scheme
        components.host = api.baseURL.host
        components.port = api.baseURL.port
        components.path = "/" + (api.path + self.path).joined(separator: "/")
        if query != nil {
            components.queryItems = try? query!.asDictionary().map { URLQueryItem(name: $0, value: "\($1)") }
        }
        
        return components.url!
    }
    
    func urlRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.uppercased()
        
        if let headers = headers {
            headers.forEach { request.addValue($1, forHTTPHeaderField: $0) }
        }
        
        if let body = body {
            request.allHTTPHeaderFields?["Content-Type"] = "application/json"
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(body)
        }
        
        if let timeout = timeout {
            request.timeoutInterval = timeout
        }
        
        return request
    }
    
}
