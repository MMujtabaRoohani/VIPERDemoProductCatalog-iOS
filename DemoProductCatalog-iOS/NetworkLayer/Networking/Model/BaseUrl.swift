//
//  BaseUrl.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import Foundation

public struct BaseURL {
    let scheme: String
    let host: String
    let port: Int?
    
    public init(scheme: String, host: String, port: Int? = nil) {
        self.scheme = scheme
        self.host = host
        self.port = port
    }
}
