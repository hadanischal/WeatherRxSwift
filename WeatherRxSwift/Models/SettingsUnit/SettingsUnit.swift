//
//  Unit.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 20/2/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

enum SettingsUnit: String, CaseIterable {
    case celsius = "metric"
    case fahrenheit = "imperial"
}

extension SettingsUnit {
    var displayName: String {
        switch self {
        case .celsius:
            return "Celsius"
        case .fahrenheit:
            return "Fahrenheit"
        }
    }

    var unitSymbol: String {
        switch self {
        case .celsius:
            return "°C"
        case .fahrenheit:
            return "°F"
        }
    }
}
