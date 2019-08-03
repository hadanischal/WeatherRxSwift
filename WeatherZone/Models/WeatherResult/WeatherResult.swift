//
//  WeatherResult.swift
//  WeatherZone
//
//  Created by Nischal Hada on 6/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

struct WeatherResult: Codable {
    let main: MainModel?
    let weather: [Weather]?
    var name: String?
}

extension WeatherResult {
    static var empty: WeatherResult {
        return WeatherResult(main: mainModel, weather: nil, name: nil)
    }
}
fileprivate let mainModel = MainModel.empty

