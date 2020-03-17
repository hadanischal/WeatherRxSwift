//
//  NetworkError.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 14/3/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case unknown
    case timeout
}
