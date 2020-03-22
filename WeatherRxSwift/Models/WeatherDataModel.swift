//
//  WeatherDataModel.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 21/3/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

struct WeatherDataModel {
    let cityName: String
    let temperature: String
    let iconURL: URL
    let mainName: String
    let description: String

    init?(_ data: WeatherResult, unit: SettingsUnit) {
        guard let name = data.name,
            let temp = data.main?.temp,
            let weatherData = data.weather?.first,
            let image = data.weather?.first?.icon,
            let imageUrl = URL.iconURL(image) else { return nil }

        self.cityName = name
        self.temperature = "\(temp) \(unit.unitSymbol)"
        self.iconURL = imageUrl
        self.mainName = weatherData.main
        self.description = weatherData.description
    }
}
