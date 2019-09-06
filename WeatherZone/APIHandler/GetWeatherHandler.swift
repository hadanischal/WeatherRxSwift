//
//  GetWeatherHandler.swift
//  WeatherZone
//
//  Created by Nischal Hada on 6/20/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

//swiftlint:disable line_length
class GetWeatherHandler: GetWeatherHandlerProtocol {
    init() {}

    func getWeatherInfo(by city: String) -> Observable<WeatherResult?> {

        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let url = URL.urlForWeatherAPI(city: cityEncoded) else { return Observable<WeatherResult?>.error(RxError.noElements) }
        let resource = Resource<WeatherResult>(url: url)
        return URLRequest.load(resource: resource)
            .map { article -> WeatherResult? in
                return article
            }.asObservable()
            .retry(2)
    }

    func getWeatherInfo(byCityIDs IDs: String) -> Observable<CityWeatherModel> {

        guard let cityEncoded = IDs.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let url = URL.urlForWeatherAPI(byCityIDs: cityEncoded) else { return Observable<CityWeatherModel>.error(RxError.noElements) }
        let resource = Resource<CityWeatherModel>(url: url)
        return URLRequest.load(resource: resource)
            .map { article -> CityWeatherModel in
                return article
            }.asObservable()
            .retry(2)
    }

}

//Call for several city IDs
//api.openweathermap.org/data/2.5/weather?id=2172797
//http://api.openweathermap.org/data/2.5/group?id=524901,703448,2643743&units=metric
//   // https://samples.openweathermap.org/data/2.5/group?id=524901,703448,2643743&units=metric&appid=b6907d289e10d714a6e88b30761fae22
