//
//  XCUIElement+Helpers.swift
//  WeatherZoneUITests
//
//  Created by Nischal Hada on 2/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import XCTest

extension XCUIElement {
    var valueAsString: String {
            return self.value as? String ?? ""
    }

    /**
     SEE: https://stackoverflow.com/questions/32897757/is-there-a-way-to-find-if-the-xcuielement-has-focus-or-not
     */
    var hasKeyboardFocus: Bool {
            return (value(forKey: "hasKeyboardFocus") as? Bool) ?? false
    }

    /**
     Only taps if element is not in focus
     SEE: https://stackoverflow.com/a/35915719

     Removes any current text in the field before typing in the new value
     SEE: https://stackoverflow.com/questions/32821880/ui-test-deleting-text-in-text-field
     */
    func clearText() {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }

        if !(self.value(forKey: "hasKeyboardFocus") as? Bool ?? false) {
            self.tap()
        }

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)

        self.typeText(deleteString)
    }

    /**
     - Parameter text: the text to enter into the field
     */
    func clearAndEnter(text: String) {
        self.clearText()
        self.typeText(text)
    }

    func enter(text: String) {
        guard (self.value as? String) != nil else {
            XCTFail("Tried to enter text into a non string value")
            return
        }

        if !(self.value(forKey: "hasKeyboardFocus") as? Bool ?? false) {
            self.tap()
        }

        self.typeText(text)
    }

    func labelContains(text: String) -> Bool {
        let predicate = NSPredicate(format: "label CONTAINS %@", text)
        return staticTexts.matching(predicate).firstMatch.exists
    }
}
