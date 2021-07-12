//
//  ProductListViewMock.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 12/07/2021.
//

import Foundation
import DemoProductCatalog_iOS

class ProductListViewMock: ProductListViewInterface {
    var presenter: ProductListPresenterInterface!
    
    var reloadCalled: Int = 0
    var insertItems: (at: Int, count: Int)?
    var errMessage: String?
    
    func mockViewDidLoad() {
        presenter.getInitialData()
    }
    
    func mockScrollToEnd() {
        presenter.getMoreData()
    }
    
    func reloadData() {
        reloadCalled += 1
    }
    
    func insert(_ count: Int, rowsAt index: Int) {
        insertItems = (index, count)
    }
    
    func showError(message: String) {
        errMessage = message
    }
    
    func mockProductClicked() {
        presenter.productSelected(product: presenter.getProduct(at: 1))
    }
}
