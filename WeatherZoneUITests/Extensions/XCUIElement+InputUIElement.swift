//
//  XCUIElement+InputUIElement.swift
//  WeatherZoneUITests
//
//  Created by Nischal Hada on 2/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import XCTest

class InputUIElement {
    var container: XCUIElement!

    lazy var textField: XCUIElement = container.textFields["inputField"]
    lazy var secureTextField: XCUIElement = container.secureTextFields["inputField"]

    lazy var rightItemView: XCUIElement = container.otherElements["rightItemContainer"]

    lazy var clearTextField: XCUIElement = textField.buttons["Clear text"]

    init(_ container: XCUIElement) {
        self.container = container
    }
}

extension XCUIElement {
    var VBStackedInputField: InputUIElement {
        get {
            return InputUIElement(self)
        }
    }
}
