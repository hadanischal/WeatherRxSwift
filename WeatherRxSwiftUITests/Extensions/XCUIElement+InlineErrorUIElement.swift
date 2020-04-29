//
//  XCUIElement+InlineErrorUIElement.swift
//  WeatherRxSwiftUITests
//
//  Created by Nischal Hada on 2/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import XCTest

class InlineErrorUIElement {
    private var container: XCUIElement!

    lazy var errorMessage: XCUIElement = container.staticTexts["errorMessage"]

    init(_ container: XCUIElement) {
        self.container = container
    }
}

extension XCUIElement {
    var inlineError: InlineErrorUIElement {
        return InlineErrorUIElement(self)
    }
}
