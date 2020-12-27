//
//  Fastlane_Screenshots.swift
//  Fastlane Screenshots
//
//  Created by Martin Albrecht on 02.10.20.
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//

import XCTest

class Fastlane_Screenshots: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        setupSnapshot(app)
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testScreenshots() throws {
        snapshot("01HomeScreen")
        
        //app/*@START_MENU_TOKEN@*/.buttons["play-alone"].tap()/*[[".buttons[\"Play alone\"]",".tap()",".press(forDuration: 0.4);",".buttons[\"play-alone\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,1]]@END_MENU_TOKEN@*/
        app.buttons["play-versus"].tap()
        app.buttons["gamecell-1-1"].tap()
        app.buttons["gamecell-0-2"].tap()
        app.buttons["gamecell-2-2"].tap()
        app.buttons["gamecell-1-0"].tap()
        
        snapshot("02GameScreen")
    }
    
    func localized(_ key: String) -> String {
        return NSLocalizedString(key, bundle: Bundle(for: Snapshot.self), comment: "")
    }
}
