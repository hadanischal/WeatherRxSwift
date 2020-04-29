//
//  Weather.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 6/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
// swiftlint:disable identifier_name
struct Weather: Codable, Equatable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
