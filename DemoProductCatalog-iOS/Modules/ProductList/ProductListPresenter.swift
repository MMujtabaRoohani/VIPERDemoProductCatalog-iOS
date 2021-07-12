//
//  ProductListPresenter.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import UIKit

class ProductListPresenter: ProductListPresenterInterface {
    weak var view: ProductListViewInterface!
    var interactor: ProductListInteractorInterface
    var router: ProductListRouterInterface
    
    private var pageNumber = 1
    private var totalPages = Int.max
    private var products: [BriefProduct] = []
    private var isFetching: Bool = false
    
    init(view: ProductListViewInterface, interactor: ProductListInteractorInterface, router: ProductListRouterInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    var moreDataAvailable: Bool {
        return pageNumber < totalPages
    }
    
    func getInitialData() {
        fetchProducts(of: 1)
    }
    
    func getMoreData() {
        guard moreDataAvailable else { return }
        fetchProducts(of: pageNumber + 1)
    }
    
    private func fetchProducts(of page: Int) {
        guard !isFetching else { return }
        isFetching = true
        interactor.getData(for: page) { [weak self] response, failure, err in
            guard let self = self else { return }
            self.isFetching = false
            guard failure == nil,
                  err == nil else {
                self.view.showError(message: failure?.message ?? (err as? NetworkError)?.description ?? "Something Unexpected Happened")
                return
            }
            self.totalPages = response?.body.lastPage ?? Int.max
            guard !(response?.body.data.isEmpty ?? true) else {
                self.totalPages = page-1 // Empty data implies that the previous page was the last page
                return
            }
            self.pageNumber = page
            if page == 1 {
                self.products = response!.body.data
                self.view.reloadData()
            } else {
                let indexToInsert = self.products.count
                self.products.append(contentsOf: response!.body.data)
                self.view.insert(response!.body.data.count, rowsAt: indexToInsert)
            }
        }
    }
    
    func productSelected(product: BriefProduct) {
        router.openProductDetails(of: product)
    }
    
    func getProductsCount() -> Int {
        products.count
    }
    
    func getProduct(at index: Int) -> BriefProduct {
        products[index]
    }
}
