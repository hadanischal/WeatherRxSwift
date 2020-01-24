//
//  XCTestCase+WaitForElement.swift
//  WeatherRxSwiftUITests
//
//  Created by Nischal Hada on 18/9/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import XCTest

extension XCTestCase {
    func waitForCondition(element: XCUIElement, predicate: NSPredicate, timeout: TimeInterval = 6.5 * UITestDelays.appearMultiplier) {
        let conditionalExpectation = expectation(for: predicate, evaluatedWith: element, handler: nil)
        wait(for: [conditionalExpectation], timeout: timeout)
    }

    func waitForElementToAppear(_ element: XCUIElement, timeout: TimeInterval = 1.5 * UITestDelays.appearMultiplier) {
        waitForCondition(element: element, predicate: NSPredicate(format: "exists == true"), timeout: timeout)
    }

    func waitForElementToDisappear(_ element: XCUIElement, timeout: TimeInterval = 6.5 * UITestDelays.disappearMultiplier) {
        waitForCondition(element: element, predicate: NSPredicate(format: "exists == false"), timeout: timeout)
    }

    func waitForHudToAppear(_ app: XCUIApplication, timeout: TimeInterval = 1.5 * UITestDelays.appearMultiplier) {
        waitForElementToAppear(app.otherElements["PKHUD"], timeout: timeout)
    }

    func waitForHudToDisappear(_ app: XCUIApplication, timeout: TimeInterval = 7.5 * UITestDelays.disappearMultiplier) {
        waitForElementToDisappear(app.otherElements["PKHUD"], timeout: timeout)
    }
}
