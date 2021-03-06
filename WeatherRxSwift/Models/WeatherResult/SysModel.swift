//
//  SysModel.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 11/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

struct SysModel: Codable, Equatable {
    let timezone: Int64?
    let country: String?
    let sunrise: Double?
    let sunset: Double?
}
