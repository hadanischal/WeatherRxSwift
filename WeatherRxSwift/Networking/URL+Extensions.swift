//
//  URL+Extensions.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 6/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

// pecker:ignore all
extension URL {
    static func urlForWeatherAPI(city: String) -> URL? {
        return URL(string: ApiKey.baseURL + "data/2.5/weather?q=\(city)&APPID=\(ApiKey.appId)&units=metric")
    }

    static func urlForWeatherAPI(byCityIDs cityIDs: String) -> URL? {
        return URL(string: ApiKey.baseURL + "data/2.5/group?id=\(cityIDs)&APPID=\(ApiKey.appId)&units=metric")
    }

    static var singleWeatherByCityName: URL? { return URL(string: ApiKey.baseURL + "data/2.5/weather") }

    static var groupWeatherById: URL? { return URL(string: ApiKey.baseURL + "data/2.5/group") }

    static func iconURL(_ icon: String) -> URL? {
        return URL(string: ApiKey.iconBaseURL + "img/wn/\(icon)@2x.png")
    }
}

// http://api.openweathermap.org/data/2.5/group?id=524901,703448,2643743&units=metric
// imperial °F or metric °C
struct ApiKey {
    static let appId = "d668412f7da6fddb022f0bc4631ba64a"
    static let baseURL = "https://api.openweathermap.org/"
    static let iconBaseURL = "http://openweathermap.org/"

    static let unitMetric = "metric"
    static let unitImperial = "imperial"
}
