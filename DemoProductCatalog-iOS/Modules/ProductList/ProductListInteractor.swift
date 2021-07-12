//
//  ProductListInteractor.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import Foundation

class ProductListInteractor: ProductListInteractorInterface {
    
    func getData(for page: Int, completion: @escaping (GetProductsList.Response?, GetProductsList.Failure?, Error?) -> Void) {
        let request = GetProductsList(queries: GetProductsList.Query.init(categoryId: 10, page: page))
        Network.shared.request(request) { result in
            switch result {
            case .success(let response):
                completion(response, nil, nil)
            case .failure(let failure):
                completion(nil, failure, nil)
            case .error(let err):
                completion(nil, nil, err)
            }
        }
    }
}
