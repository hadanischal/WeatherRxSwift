//
//  CityWeatherModel.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 6/21/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
// Current weather bulks for city list
struct CityWeatherModel: Codable {
    var cnt: Int?
    var list: [WeatherResult]?
}
