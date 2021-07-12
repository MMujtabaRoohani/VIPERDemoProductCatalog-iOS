//
//  Error.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import Foundation

public enum NetworkError: Error {
    case requestCreation
    case decoding(Data?, Error)
    case server(Data?, Error)
    
    var description: String {
        
        #if DEBUG
        switch self {
        case .requestCreation:
            return "Request couldn't be made"
        case .decoding(_, let err):
            return (err as? DecodingError).debugDescription
        case .server(_, let err):
            return err.localizedDescription
        }
        #else
        switch self {
        case .requestCreation:
            return "Request couldn't be made"
        case .decoding(_, let err), .server(_, let err):
            return err.localizedDescription
        }
        #endif
    }
}
