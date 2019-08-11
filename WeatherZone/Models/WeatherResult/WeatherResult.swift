//
//  WeatherResult.swift
//  WeatherZone
//
//  Created by Nischal Hada on 6/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

struct WeatherResult: Codable {
    let main: MainModel? //for temprature
    let weather: [Weather]? //for icon, description
    let sys: SysModel?
    let visibility: Double?
    let wind: WindModel?
    var name: String?
}

extension WeatherResult {
    static var empty: WeatherResult {
        return WeatherResult(main: nil, weather: nil, sys: nil, visibility: nil, wind: nil, name: nil)
    }
}
