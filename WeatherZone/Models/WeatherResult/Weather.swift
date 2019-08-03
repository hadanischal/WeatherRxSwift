//
//  Weather.swift
//  WeatherZone
//
//  Created by Nischal Hada on 6/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
