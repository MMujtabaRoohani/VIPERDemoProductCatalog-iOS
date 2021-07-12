//
//  ProductListUITest.swift
//  DemoProductCatalog-iOSUITests
//
//  Created by Mujy on 12/07/2021.
//

import XCTest

class ProductListUITest: XCTestCase {

    var app: XCUIApplication!
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testClickableTableViewCells() throws {
        self.app.tables.element.cells.element.waitForExistence(timeout: 5)
        self.app.tables.element.cells.allElementsBoundByIndex.first?.tap()
        self.app.navigationBars.element.buttons.element.waitForExistence(timeout: 2)
        self.app.navigationBars.element.buttons.element.tap()
        for _ in 0..<20 {
            self.app.swipeUp(velocity: .fast)
        }
    }

}
