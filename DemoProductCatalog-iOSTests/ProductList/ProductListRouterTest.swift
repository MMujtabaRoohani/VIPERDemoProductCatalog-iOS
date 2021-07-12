//
//  ProductListRouterTest.swift
//  DemoProductCatalog-iOSTests
//
//  Created by Mujy on 12/07/2021.
//

import XCTest

class ProductListRouterTest: XCTestCase {

    var sut: ProductListRouterInterface!
    var navigationController: UINavigationController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        navigationController = UINavigationController()
        sut = ProductListRouter(nav: navigationController)
    }

    override func tearDownWithError() throws {
        navigationController = nil
        sut = nil
        try super.tearDownWithError()
    }

    /// Tests all the functionality of router
    func testRouterStart() throws {
        // Testing if the router correctly puts everything in place
        sut.start()
        
        let view = navigationController.visibleViewController as? ProductListViewInterface
        let presenter = view?.presenter
        let interactor = presenter?.interactor
        XCTAssert(view != nil && presenter != nil && interactor != nil)
        
        // Testing if the router correctly puts everything in place after pushing the next view controller
        let expectation = XCTestExpectation(description: "Push Product Detail Page")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.sut.openProductDetails(of: BriefProduct(productId: 2075, thumbnailURL: "", name: "", vendorName: "", finalPrice: ""))
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let view = self.navigationController.visibleViewController as? ProductDetailViewInterface
                let presenter = view?.presenter
                let interactor = presenter?.interactor
                XCTAssert(view != nil && presenter != nil && interactor != nil)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5)
        
    }
}
