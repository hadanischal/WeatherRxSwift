//
//  CityWeatherModel.swift
//  WeatherZone
//
//  Created by Nischal Hada on 6/21/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

struct CityWeatherModel: Codable {
    var cnt: Int?
    var list: [WeatherResult]?
}
