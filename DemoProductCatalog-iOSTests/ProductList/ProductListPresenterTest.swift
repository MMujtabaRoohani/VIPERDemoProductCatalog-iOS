//
//  ProductListPresenterTest.swift
//  DemoProductCatalog-iOSTests
//
//  Created by Mujy on 12/07/2021.
//

import XCTest

class ProductListPresenterTest: XCTestCase {

    let view = ProductListViewMock()
    let router = ProductListRouterMock()
    let interactor = ProductListInteractorMock()
    
    var sut: ProductListPresenterInterface!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ProductListPresenter(view: view, interactor: interactor, router: router)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    /// This test verifies that the presenter responds to all the events called by the view
    func testPresenter() throws {
        view.presenter = sut
        
        // Start Testing
        view.mockViewDidLoad()
        
        // Interactor will respond synchronously
        XCTAssert(view.reloadCalled == 1)
        XCTAssert(sut.getProductsCount() == 10)
        for idx in 0..<sut.getProductsCount() {
            let product: BriefProduct? = sut.getProduct(at: idx)
            XCTAssert(product != nil) // Bogus check just to verify that no IndexOutOfBoundException is raised
        }
        
        view.mockScrollToEnd()
        XCTAssert(view.insertItems != nil && view.insertItems!.at == 10 && view.insertItems!.count == 2)
        XCTAssert(sut.moreDataAvailable == false)
        view.insertItems = nil // Setting it nil to verify if its called sometime later
        
        view.mockProductClicked()
        XCTAssert(router.openProductDetailsCalledCount == 1)
        
        view.mockScrollToEnd()
        XCTAssert(view.insertItems == nil)
    }

}
