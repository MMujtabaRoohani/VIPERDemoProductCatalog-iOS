//
//  Result.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import Foundation

public enum NetworkResult<V, W, E: Error> {
    case success(V)
    case failure(W)
    case error(E)
}
