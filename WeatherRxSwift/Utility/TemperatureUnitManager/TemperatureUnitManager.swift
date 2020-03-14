//
//  TemperatureUnitManager.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 14/3/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

enum TemperatureUnitKey: String {
    case unit = "unit_type"
}

protocol TemperatureUnitManagerProtocol {
    func setTemperatureUnit(_ unit: SettingsUnit)
    func getTemperatureUnit() -> SettingsUnit
}

final class TemperatureUnitManager: TemperatureUnitManagerProtocol {

    private let userDefaultsManager: UserDefaultsManagerProtocol

    init(_ userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()) {
        self.userDefaultsManager = userDefaultsManager
    }

    func setTemperatureUnit(_ unit: SettingsUnit) {
        userDefaultsManager.set(value: unit.rawValue, forKey: TemperatureUnitKey.unit.rawValue)
    }

    func getTemperatureUnit() -> SettingsUnit {
        guard let unit = userDefaultsManager.string(forKey: TemperatureUnitKey.unit.rawValue),
            let temperatureUnit = SettingsUnit(rawValue: unit) else {
                assertionFailure("SettingsUnit not found")
                return SettingsUnit.celsius
        }
        return temperatureUnit
    }
}
