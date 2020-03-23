//
//  ManualMocks.swift
//  WeatherRxSwiftTests
//
//  Created by Nischal Hada on 19/3/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation
@testable import WeatherRxSwift

struct MocksInfo {
    static let coord = Coord(lon: 151.207321, lat: -33.867851)
    static let cityList = CityListModel(id: 2147714, name: "Sydney", coord: coord, country: "AU")
    static let mainModel = MainModel(temp: 18.52, pressure: 1003, humidity: 72, temp_min: 17.78, temp_max: 19.44)
    static let weather = Weather(id: 803, main: "Clouds", description: "broken clouds", icon: "04d")
    static let weatherResult = WeatherResult(main: mainModel, weather: [weather], sys: nil, visibility: 10, wind: nil, name: "Sydney")
    static let citysWeatherResult = CityWeatherModel(cnt: 1, list: [weatherResult])
    
    static func mockDetailModelList() -> [DetailModel] {
        return updateDetailList()
    }
    
    private static func updateDetailList() -> [DetailModel] {
        let sunrise = Date(timeIntervalSince1970: weatherResult.sys?.sunrise ?? 0.00)
        let sunset = Date(timeIntervalSince1970: weatherResult.sys?.sunset ?? 0.00)
        
        var detailModel = MockData().stubDetailModelList()
        
        detailModel[WeatherDetail.sunrise.rawValue].description = sunrise.time
        detailModel[WeatherDetail.sunset.rawValue].description = sunset.time
        detailModel[WeatherDetail.pressure.rawValue].description = "\(weatherResult.main?.pressure ?? 0)"
        detailModel[WeatherDetail.humidity.rawValue].description = "\(weatherResult.main?.humidity ?? 0)"
        detailModel[WeatherDetail.tempMin.rawValue].description = "\(weatherResult.main?.temp_min ?? 0)"
        detailModel[WeatherDetail.tempMax.rawValue].description = "\(weatherResult.main?.temp_max ?? 0)"
        detailModel[WeatherDetail.wind.rawValue].description = "\(weatherResult.wind?.speed ?? 0)"
        detailModel[WeatherDetail.visibility.rawValue].description = "\(weatherResult.visibility ?? 0)"
        
        return detailModel
    }

}
