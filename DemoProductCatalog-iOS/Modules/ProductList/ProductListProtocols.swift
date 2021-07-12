//
//  ProductListProtocols.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import UIKit

protocol ProductListViewInterface: AnyObject {
    var presenter: ProductListPresenterInterface! { get set }
    
    func reloadData()
    func insert(_ count: Int, rowsAt index: Int)
    func showError(message: String)
}

protocol  ProductListPresenterInterface: AnyObject {
    
    var view: ProductListViewInterface! { get set }
    var interactor: ProductListInteractorInterface { get set }
    var router: ProductListRouterInterface { get set }
    
    var moreDataAvailable: Bool { get }
    
    func getInitialData()
    func getMoreData()
    func productSelected(product: BriefProduct)
    func getProductsCount() -> Int
    func getProduct(at index: Int) -> BriefProduct
}

protocol ProductListInteractorInterface: AnyObject {
    func getData(for page: Int, completion: @escaping (GetProductsList.Response?, GetProductsList.Failure?, Error?) -> Void)
}

protocol ProductListRouterInterface: AnyObject {
    var navigationController: UINavigationController { get }
    
    func start()
    func openProductDetails(of product: BriefProduct)
}
