//
//  WeatherViewModelProtocol.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 6/17/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import RxSwift

protocol WeatherViewModelProtocol {
    var weatherList: Observable<WeatherResult> { get }
    func getWeatherInfo(by city: String)
}
