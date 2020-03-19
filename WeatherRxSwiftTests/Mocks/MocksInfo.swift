//
//  ManualMocks.swift
//  WeatherRxSwiftTests
//
//  Created by Nischal Hada on 19/3/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation
@testable import WeatherRxSwift

struct MocksInfo {
    static let coord = Coord(lon: 151.207321, lat: -33.867851)
    static let cityList = CityListModel(id: 2147714, name: "Sydney", coord: coord, country: "AU")
    static let mainModel = MainModel(temp: 18.52, pressure: 1003, humidity: 72, temp_min: 17.78, temp_max: 19.44)
    static let weather = Weather(id: 803, main: "Clouds", description: "broken clouds", icon: "04d")
    static let weatherResult = WeatherResult(main: mainModel, weather: [weather], sys: nil, visibility: 10, wind: nil, name: "Sydney")
    static let citysWeatherResult = CityWeatherModel(cnt: 1, list: [weatherResult])
}
