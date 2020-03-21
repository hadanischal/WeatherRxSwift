//
//  CityListViewModel.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 6/20/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol CityListDataSource {
    var weatherList: Observable<[WeatherResult]> { get }
    var errorMessage: Observable<String> { get }
    var temperatureUnit: SettingsUnit { get }
    func getWeatherInfoForCityList()
    func fetchWeatherFor(selectedCity cityName: CityListModel)
}

final class CityListViewModel: CityListDataSource {

    //output
    var weatherList: Observable<[WeatherResult]>
    var errorMessage: Observable<String>
    var temperatureUnit: SettingsUnit { self.temperatureManager.getTemperatureUnit() }

    //input
    private var cityList: [CityListModel] = []
    private let cityListHandler: CityListInteracting
    private let temperatureManager: TemperatureUnitManagerProtocol

    private let weatherListRelay: BehaviorRelay<[WeatherResult]> = BehaviorRelay(value: [])
    private let errorSubject = PublishSubject<String>()
    private let disposeBag = DisposeBag()

    init(withCityList cityListHandler: CityListInteracting = CityListInteractor(),
         temperatureManager: TemperatureUnitManagerProtocol = TemperatureUnitManager()) {

        self.cityListHandler = cityListHandler
        self.temperatureManager = temperatureManager

        self.weatherList = weatherListRelay.asObservable()
        self.errorMessage = errorSubject.asObservable()
        self.syncTask()
    }

    private func syncTask() {
        Observable<Int>.interval(.seconds(300), scheduler: ConcurrentDispatchQueueScheduler(qos: DispatchQoS.utility))
            .flatMap { [weak self] _ -> Observable<[CityListModel]> in
                return self?.getCityListFromFile() ?? Observable.error(NetworkError.unknown)
            }
            .flatMap { [weak self] cityList ->  Observable<[WeatherResult]>  in
                return self?.cityListHandler.getWeatherInfo(forCityList: cityList) ?? Observable.error(NetworkError.unknown)
            }
            .subscribe(onNext: { [weak self] wetherInfo in
                self?.weatherListRelay.accept(wetherInfo)
                }, onError: { _ in
                    self.errorSubject.onNext("Unable to get weather information for city list.")
            }).disposed(by: disposeBag)
    }

    // MARK: - Get Citylist from jsonfile Then make API Request

     func getWeatherInfoForCityList() {
        self.getCityListFromFile()
            .flatMap { [weak self] cityList -> Observable<[WeatherResult]> in
                return self?.cityListHandler.getWeatherInfo(forCityList: cityList) ?? Observable.error(NetworkError.unknown)
            }
            .subscribe(onNext: { [weak self] wetherInfo in
                self?.weatherListRelay.accept(wetherInfo)
                }, onError: { _ in
                    self.errorSubject.onNext("Unable to get weather information for city list.")
            }).disposed(by: disposeBag)
    }

    // MARK: - Fetch weather for selected city

    func fetchWeatherFor(selectedCity city: CityListModel) {

        let foundItems = self.cityList.filter { $0.id == city.id }.first
        //add city if its not in list
        guard foundItems == nil else { self.errorSubject.onNext("City already added in city list.") ; return }
        self.cityList.append(city)

        self.cityListHandler
            .getWeatherInfo(forCity: city)
            .subscribe(onNext: { [weak self] weatherResult in
                guard let self = self else { return }
                self.weatherListRelay.accept(self.weatherListRelay.value + [weatherResult])
                }, onError: { error in
                    print("selectedCity onError: \(error)")
                    self.errorSubject.onNext("Unable to get weather information for selected city.")
            })
            .disposed(by: disposeBag)
    }

    // MARK: - Get Citylist from jsonfile
    private func getCityListFromFile() -> Observable<[CityListModel]> {
        // Get from file if city list is empty
        return Observable.just(cityList)
            .flatMap { [weak self] cityList -> Observable<[CityListModel]> in
                guard cityList.isEmpty else { return Observable.just(cityList)}
                return self?.cityListHandler
                    .getCityListFromFile()
                    .flatMap { [weak self] cityList -> Observable<[CityListModel]> in
                        self?.cityList = cityList
                        return Observable.just(cityList)
                    }  ?? Observable.error(NetworkError.badURL)
            }
    }
}
