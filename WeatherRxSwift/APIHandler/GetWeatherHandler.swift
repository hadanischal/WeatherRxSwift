//
//  GetWeatherHandler.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 6/20/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import RxSwift
import UIKit

protocol GetWeatherHandlerProtocol {
    func getWeatherInfo(by city: String) -> Observable<WeatherResult?>
    func getWeatherInfo(byCityIDs IDs: String) -> Observable<CityWeatherModel>
}

class GetWeatherHandler: GetWeatherHandlerProtocol {
    private let networkingManager: NetworkingManager
    private let temperatureManager: TemperatureUnitManagerProtocol

    init(_ networkingManager: NetworkingManager = NetworkManager(),
         temperatureManager: TemperatureUnitManagerProtocol = TemperatureUnitManager()) {
        self.networkingManager = networkingManager
        self.temperatureManager = temperatureManager
    }

    func getWeatherInfo(by city: String) -> Observable<WeatherResult?> {
        guard let url = URL.singleWeatherByCityName else { return Observable.error(NetworkError.badURL) }

        let payLoad: [String: String] = ["q": city,
                                         "units": temperatureManager.getTemperatureUnit().rawValue,
                                         "APPID": ApiKey.appId]

        let resource = Resource<WeatherResult>(url: url, parameter: payLoad)

        return networkingManager.load(resource: resource)
            .map { article -> WeatherResult? in
                article
            }
            .asObservable()
            .retry(2)
    }

    func getWeatherInfo(byCityIDs IDs: String) -> Observable<CityWeatherModel> {
        // let cityEncoded = IDs.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
        guard let url = URL.groupWeatherById else { return Observable.error(NetworkError.badURL) }
        let payLoad: [String: String] = ["id": IDs,
                                         "units": temperatureManager.getTemperatureUnit().rawValue,
                                         "APPID": ApiKey.appId]
        let resource = Resource<CityWeatherModel>(url: url, parameter: payLoad)
        return networkingManager.load(resource: resource)
            .map { article -> CityWeatherModel in
                article
            }
            .asObservable()
            .retry(2)
    }
}

// "https://api.openweathermap.org/data/2.5/group?id=2147714,4163971,1023656,7839562,2063523,2165087,2147291&APPID=d668412f7da6fddb022f0bc4631ba64a&units=metric" -i -v
// "https://api.openweathermap.org/data/2.5/weather?q=Merida&APPID=d668412f7da6fddb022f0bc4631ba64a&units=metric" -i -v
