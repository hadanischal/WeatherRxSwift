//
//  CityListInteractor.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 16/3/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation
import RxSwift

protocol CityListInteracting {
    func getCityListFromFile() -> Observable<[CityListModel]>
    func getWeatherInfo(forCityList cityList: [CityListModel]) -> Observable<[WeatherResult]>
    func getWeatherInfo(forCity city: CityListModel) -> Observable<WeatherResult>
}

final class CityListInteractor: CityListInteracting {
    private let cityListHandler: StartCityListHandlerProtocol
    private let weatherHandler: GetWeatherHandlerProtocol

    init(withCityList cityListHandler: StartCityListHandlerProtocol = FileManagerWraper(),
         withGetWeather weatherHandler: GetWeatherHandlerProtocol = GetWeatherHandler()) {
        self.cityListHandler = cityListHandler
        self.weatherHandler = weatherHandler
    }

    // MARK: - Get Citylist from jsonfile

    func getCityListFromFile() -> Observable<[CityListModel]> {
        self.cityListHandler
            .getStartCityList()
            .catchErrorJustReturn([])
    }

    // Get weather list for city list
    func getWeatherInfo(forCityList cityList: [CityListModel]) -> Observable<[WeatherResult]> {
        let cityIds = cityList
            .compactMap { $0.id }
            .compactMap { String($0) }
            .joined(separator: ",")

        return self.weatherHandler
            .getWeatherInfo(byCityIDs: cityIds)
            .compactMap { $0.list }
            .asObservable()
    }

    // MARK: - Fetch weather for selected city

    func getWeatherInfo(forCity city: CityListModel) -> Observable<WeatherResult> {
        guard let name = city.name else { return Observable.error(NetworkError.badURL) }

        return Observable.just(name)
            .flatMap { name -> Observable<WeatherResult?> in
                self.weatherHandler.getWeatherInfo(by: name)
            }
            .compactMap { $0 }
    }
}
