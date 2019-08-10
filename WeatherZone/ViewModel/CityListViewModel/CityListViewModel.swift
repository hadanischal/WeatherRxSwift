//
//  CityListViewModel.swift
//  WeatherZone
//
//  Created by Nischal Hada on 6/20/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CityListViewModel: CityListViewModelProtocol {
    //input
    private let cityListHandler: CityListHandlerProtocol
    private let weatherHandler: GetWeatherHandlerProtocol

    //output
    var cityList: [CityListModel]!
    var weatherList: Observable<[WeatherResult]>
    let weatherListBehaviorRelay: BehaviorRelay<[WeatherResult]> = BehaviorRelay(value: [])

    private let disposeBag = DisposeBag()

    init(withCityList cityListHandler: CityListHandlerProtocol = CityListHandler(),
         withGetWeather weatherHandler: GetWeatherHandlerProtocol = GetWeatherHandler()) {
        self.cityListHandler = cityListHandler
        self.weatherHandler = weatherHandler
        self.weatherList = weatherListBehaviorRelay.asObservable()
        self.cityList = []
        self.syncTask()
        self.getCityListFromFile()
    }

    private func syncTask() {
        let scheduler = SerialDispatchQueueScheduler(qos: .default)
        Observable<Int>.interval(.seconds(200), scheduler: scheduler)
            .subscribe { [weak self] event in
                print(event)
                self?.getWeatherInfoForCityList()
            }.disposed(by: disposeBag)
    }

    // MARK: - Get Citylist from jsonfile

     func getCityListFromFile() {
        self.cityListHandler
            .getCityInfo(withFilename: "StartCity")
            .subscribe(onNext: { [weak self] cityListModel in
                self?.cityList = cityListModel
                self?.getWeatherInfoForCityList()
                }, onError: { error in
                    print("getCityInfo error :", error)
            }).disposed(by: disposeBag)
    }

    // Get weather list for city list
    private func getWeatherInfoForCityList() {
        let arrayId = cityList.map { String($0.id!) }
        let stringIds = arrayId.joined(separator: ",")

        self.weatherHandler
            .getWeatherInfo(byCityIDs: stringIds)
            .subscribe(onNext: { [weak self] cityListWeather in
                if let weatherList = cityListWeather.list {
                    self?.weatherListBehaviorRelay.accept(weatherList)
                }
                }, onError: { error in
                    print("WeatherInfoForCityList error :", error)
            }).disposed(by: disposeBag)
    }

    // MARK: - Fetch weather for selected city

    func fetchWeatherFor(selectedCity city: CityListModel) {
        let foundItems = self.cityList.filter {$0.id == city.id }

        if foundItems.count == 0, //add city if its not in list
            let cityId = city.name {

            self.cityList.append(city)

            self.weatherHandler
                .getWeatherInfo(by: "\(cityId)")
                .subscribe(onNext: { [weak self] weatherResult in

                    if
                        let weatherValue = weatherResult,
                        let weatherRelayValue = self?.weatherListBehaviorRelay.value
                    {
                        var weatherListAppended = weatherRelayValue
                        weatherListAppended.append(weatherValue)
                        self?.weatherListBehaviorRelay.accept(weatherListAppended)
                    }

                    }, onError: { error in
                        print("selectedCity error :", error)
                }).disposed(by: disposeBag)
        }

    }
}
