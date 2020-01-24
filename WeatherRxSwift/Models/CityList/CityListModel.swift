//
//  CityListModel.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 6/20/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

//swiftlint:disable identifier_name
struct CityListModel: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
}
