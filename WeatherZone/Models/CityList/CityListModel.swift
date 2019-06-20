//
//  CityListModel.swift
//  WeatherZone
//
//  Created by Nischal Hada on 6/20/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

struct CityResult: Codable {
    var list: [CityListModel]
}

struct CityListModel: Codable{
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
}
