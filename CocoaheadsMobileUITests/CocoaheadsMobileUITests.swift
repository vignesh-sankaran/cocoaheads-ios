//
//  CocoaheadsMobileUITests.swift
//  CocoaheadsMobileUITests
//
//  Created by Vignesh Sankaran on 7/11/19.
//  Copyright © 2019 Melbourne CocoaHeads. All rights reserved.
//

import XCTest

class CocoaheadsMobileUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        app.launch()
    }

    func testGoToEventDetail() {
        let firstEventRow = app.tables.cells.matching(.cell, identifier: "eventCell").firstMatch
        
        guard firstEventRow.waitForExistence(timeout: 10) == true else {
            return XCTFail("Unable to find event cell")
        }

        firstEventRow.tap()
        
        let eventDetailWebView = app.webViews.firstMatch
        _ = eventDetailWebView.waitForExistence(timeout: 10)

        XCTAssert(eventDetailWebView.exists, "Event detail web view does not exist!")
    }
}
