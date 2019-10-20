//
//  MockError.swift
//  WeatherZoneTests
//
//  Created by Nischal Hada on 12/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import XCTest

enum MockError: Error, Equatable {
    case noElements
}

let testError = NSError(domain: "dummyError", code: -232, userInfo: nil)
let testError1 = MockError.noElements
