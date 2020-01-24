//
//  MainModel.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 3/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

// swiftlint:disable all
struct MainModel: Codable {
    let temp: Double
    let pressure: Double
    let humidity: Double
    let temp_min: Double
    let temp_max: Double
}

extension MainModel {
    static var empty: MainModel {
        return MainModel(temp: 0.00, pressure: 0.00, humidity: 0.00, temp_min: 0.00, temp_max: 0.00)
    }
}
