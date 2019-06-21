//
//  URL+Extensions.swift
//  WeatherZone
//
//  Created by Nischal Hada on 6/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

extension URL {
    static func urlForWeatherAPI(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=\(ApiKey.appId)&units=metric")
    }
    
    static func urlForWeatherAPI(byCityIDs cityIDs: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/group?id=\(cityIDs)&APPID=\(ApiKey.appId)&units=metric")
    }
}
//http://api.openweathermap.org/data/2.5/group?id=524901,703448,2643743&units=metric
//imperial °F or metric °C
struct ApiKey {
    static let appId = "d668412f7da6fddb022f0bc4631ba64a"
}
