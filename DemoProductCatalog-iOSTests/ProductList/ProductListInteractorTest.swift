//
//  ProductListInteractorTest.swift
//  DemoProductCatalog-iOSTests
//
//  Created by Mujy on 12/07/2021.
//

import XCTest
@testable import DemoProductCatalog_iOS

class ProductListInteractorTest: XCTestCase {

    var sut: ProductListInteractorInterface!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ProductListInteractor()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    /// Testing if the interactor is always giving a single non-null argument in closure and handles success and failure correctly
    func testInteractor() throws {
        let expectation1 = XCTestExpectation(description: "Success Case")
        let expectation2 = XCTestExpectation(description: "Failure Case")
        
        sut.getData(for: 0) { response, failure, err in
            let nonNullCount = [response as Any?, failure as Any?, err as Any?].compactMap { $0 }.count
            XCTAssert(nonNullCount == 1)
            XCTAssert(response != nil)
            expectation1.fulfill()
        }
        sut.getData(for: Int.max) { response, failure, err in
            let nonNullCount = [response as Any?, failure as Any?, err as Any?].compactMap { $0 }.count
            XCTAssert(nonNullCount == 1)
            XCTAssert(response == nil)
            expectation2.fulfill()
        }
        wait(for: [expectation1, expectation2], timeout: 5)
    }

}
