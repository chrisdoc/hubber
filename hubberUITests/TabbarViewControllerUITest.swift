//
//  TabbarViewControllerTest.swift
//  Hubber
//
//  Created by Christoph Kieslich on 13/10/2016.
//  Copyright © 2016 Husten. All rights reserved.
//

import XCTest

class TabbarViewControllerUITest: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCorrectNumberOfTabs() {
        let app = XCUIApplication()
        XCTAssertEqual(app.tabBars.buttons.count, 2)
        XCTAssertTrue(app.tabBars.buttons["Users"].exists)
        XCTAssertTrue(app.tabBars.buttons["Repositories"].exists)
    }
    
}
