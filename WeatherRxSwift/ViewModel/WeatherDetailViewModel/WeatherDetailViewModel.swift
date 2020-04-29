//
//  WeatherDetailViewModel.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 11/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift

protocol WeatherDetailDataSource {
    var title: Observable<String> { get }
    var weatherDataModel: WeatherDataModel? { get }
    var detailList: Observable<[DetailModel]> { get }
    func getDetailResult()
}

final class WeatherDetailViewModel: WeatherDetailDataSource {
    // Output
    var title: Observable<String> { Observable.just(weatherResult.name ?? "Detail") }
    var weatherDataModel: WeatherDataModel?
    let detailList: Observable<[DetailModel]>

    // Input
    private var weatherResult: WeatherResult

    private let detailListHandler: DetailListHandlerProtocol
    private let backgroundScheduler: SchedulerType
    private let temperatureManager: TemperatureUnitManagerProtocol

    private var detailSubject = PublishSubject<[DetailModel]>()
    private var detailModel: [DetailModel]!
    private let disposeBag = DisposeBag()

    init(withDetailListHandler detailListHandler: DetailListHandlerProtocol = FileManagerWraper(),
         withWeatherResultModel weatherResult: WeatherResult,
         temperatureManager: TemperatureUnitManagerProtocol = TemperatureUnitManager(),
         withSchedulerType backgroundScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
        self.detailListHandler = detailListHandler
        self.backgroundScheduler = backgroundScheduler
        self.weatherResult = weatherResult
        self.temperatureManager = temperatureManager

        self.weatherDataModel = WeatherDataModel(weatherResult, unit: self.temperatureManager.getTemperatureUnit())
        self.detailList = detailSubject.asObservable()
    }

    func getDetailResult() {
        self.detailListHandler
            .getDetailInfo()
            .subscribeOn(backgroundScheduler)
            .subscribe(onNext: { [weak self] detailList in
                self?.detailModel = detailList
                self?.updateDetailList()
            }, onError: { error in
                print("onError: \(error)")
            }).disposed(by: disposeBag)
    }

    private func updateDetailList() {
        let sunrise = Date(timeIntervalSince1970: weatherResult.sys?.sunrise ?? 0.00)
        let sunset = Date(timeIntervalSince1970: weatherResult.sys?.sunset ?? 0.00)

        self.detailModel[WeatherDetail.sunrise.rawValue].description = sunrise.time
        self.detailModel[WeatherDetail.sunset.rawValue].description = sunset.time
        self.detailModel[WeatherDetail.pressure.rawValue].description = "\(weatherResult.main?.pressure ?? 0)"
        self.detailModel[WeatherDetail.humidity.rawValue].description = "\(weatherResult.main?.humidity ?? 0)"
        self.detailModel[WeatherDetail.tempMin.rawValue].description = "\(weatherResult.main?.temp_min ?? 0)"
        self.detailModel[WeatherDetail.tempMax.rawValue].description = "\(weatherResult.main?.temp_max ?? 0)"
        self.detailModel[WeatherDetail.wind.rawValue].description = "\(weatherResult.wind?.speed ?? 0)"
        self.detailModel[WeatherDetail.visibility.rawValue].description = "\(weatherResult.visibility ?? 0)"

        self.detailSubject.onNext(detailModel)
    }
}
