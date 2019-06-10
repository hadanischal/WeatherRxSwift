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
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=\(ApiKey.appId)&units=imperial")
    }
}

struct ApiKey {
    static let appId = "d668412f7da6fddb022f0bc4631ba64a"
}
