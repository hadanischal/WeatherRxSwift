//
//  WeatherResult.swift
//  WeatherZone
//
//  Created by Nischal Hada on 6/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

struct WeatherResult: Codable {
    let main: Weather?
    var name: String?
}

extension WeatherResult {
    static var empty: WeatherResult {
        return WeatherResult (main: Weather(temp: 0.0, humidity: 0.0), name: "")        
    }
}
