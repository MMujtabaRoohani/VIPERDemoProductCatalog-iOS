//
//  ProductDetailProtocols.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import UIKit

protocol ProductDetailViewInterface: AnyObject {
    var presenter: ProductDetailPresenterInterface! { get set }
    
    func populateData(with title: String, description: NSAttributedString)
    func reloadImagesCollection()
    func showError(message: String)
}

protocol  ProductDetailPresenterInterface: AnyObject {
    
    var view: ProductDetailViewInterface! { get set }
    var interactor: ProductDetailInteractorInterface { get set }
    var router: ProductDetailRouterInterface { get set }
    
    var briefProduct: BriefProduct { get }
    
    func fetchProductData()
    func getImageURL(at index: Int) -> URL
    func getImagesCount() -> Int
}

protocol ProductDetailInteractorInterface: AnyObject {
    func getData(for product: BriefProduct, completion: @escaping (GetProductDetail.Response?, GetProductDetail.Failure?, Error?) -> Void)
}

protocol ProductDetailRouterInterface: AnyObject {
    var navigationController: UINavigationController { get }
    
    func start(with product: BriefProduct)
    func goBack()
}
