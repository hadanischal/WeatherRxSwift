//
//  WeatherViewModel.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 6/17/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import RxSwift
import UIKit

final class WeatherViewModel: WeatherViewModelProtocol {
    private let getWeatherHandler: GetWeatherHandlerProtocol
    private let disposeBag = DisposeBag()
    var weatherList: Observable<WeatherResult>
    var title: String { return L10n.DashBoard.titleAddCity }

    private let weatherListSubject = PublishSubject<WeatherResult>()

    init(withGetWeather getWeatherHandler: GetWeatherHandlerProtocol = GetWeatherHandler()) {
        self.getWeatherHandler = getWeatherHandler
        self.weatherList = weatherListSubject.asObserver()
    }

    func getWeatherInfo(by city: String) {
        getWeatherHandler.getWeatherInfo(by: city)
            .retry(3)
            .catchError { error -> Observable<WeatherResult?> in
                print(error.localizedDescription)
                return Observable.just(WeatherResult.empty)
            }
            .subscribe(onNext: { [weak self] result in
                if let result = result {
                    self?.weatherListSubject.onNext(result)
                }
            }, onError: { error in
                print("getWeatherInfo onError: \(error)")
            })
            .disposed(by: disposeBag)
    }
}

/*
 //        let search = URLRequest.load(resource: resource)
 //            .observeOn(MainScheduler.instance)
 //            .retry(3)
 //            .catchError { error in
 //                print(error.localizedDescription)
 //                return Observable.just(WeatherResult.empty)
 //            }.asDriver(onErrorJustReturn: WeatherResult.empty)
 */

/*
 .catchError{ error -> Observable<WeatherResult?> in
 print(error.localizedDescription)
 return Observable.just(WeatherResult.empty)
 }
 */
