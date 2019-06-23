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
    private let cityListHandler: CityListHandlerProtocol
    private let getWeatherHandler: GetWeatherHandlerProtocol

    private let disposeBag = DisposeBag()
    var weatherList: Observable<[WeatherResult]>
    private let weatherListSubject = PublishSubject<[WeatherResult]>()

    init(withCityList cityListHandler: CityListHandlerProtocol = CityListHandler(), withGetWeather getWeatherHandler: GetWeatherHandlerProtocol = GetWeatherHandler()) {
        self.cityListHandler = cityListHandler
        self.getWeatherHandler = getWeatherHandler
        self.weatherList = weatherListSubject.asObservable()
        self.getWeatherInfo()
        self.syncTask()
    }

    private func syncTask() {
        let scheduler = SerialDispatchQueueScheduler(qos: .default)
        Observable<Int>.interval(.seconds(200), scheduler: scheduler)
            .subscribe { [weak self] event in
                print(event)
                self?.getWeatherInfo()
            }.disposed(by: disposeBag)
    }

   private func getWeatherInfo() {
        self.cityListHandler
            .getCityInfo(withFilename: "StartCity")
            .flatMap { [weak self] list -> Observable<CityWeatherModel> in
                let arrayId = list.map { String($0.id!) }
                let stringIds = arrayId.joined(separator: ",")
                return self?.getWeatherHandler
                    .getWeatherInfo(byCityIDs: stringIds)
                    .catchError({ _ -> Observable<CityWeatherModel> in
                        return Observable<CityWeatherModel>.empty()
                    }) ?? Observable<CityWeatherModel>.empty()
            }.subscribe(onNext: { [weak self] response in
                if let weatherInfo = response.list {
                    self?.weatherListSubject.on(.next(weatherInfo))
                }
            }, onError: { error in
                print("VM error :", error)
            }).disposed(by: disposeBag)
    }
}
