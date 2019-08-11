//
//  WeatherDetailViewModel.swift
//  WeatherZone
//
//  Created by Nischal Hada on 11/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift

class WeatherDetailViewModel: WeatherDetailDelegate {

    //input
    private let detailListHandler: DetailListHandlerProtocol
    private let backgroundScheduler: SchedulerType
    private var weatherResult: WeatherResult!

    private var detailModel: [DetailModel]!

    //output
    var detailList: Observable<[DetailModel]>

    private var detailSubject = PublishSubject<[DetailModel]>()
    private let disposeBag = DisposeBag()

    init(withDetailListHandler detailListHandler: DetailListHandlerProtocol = DetailListHandler(),
         withWeatherResultModel weatherResult: WeatherResult,
         withSchedulerType backgroundScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)
        ) {
        self.detailListHandler = detailListHandler
        self.backgroundScheduler = backgroundScheduler
        self.weatherResult = weatherResult

        self.detailList = detailSubject.asObserver()
        self.getDetailResult()
    }

     func getDetailResult() {
        self.detailListHandler
            .getDetailInfo(withFilename: "detailList")
            .subscribeOn(backgroundScheduler)
            .subscribe(onNext: { [weak self] detailList in
                self?.detailModel = detailList
                self?.updateDetailList()
                 }, onError: { error in
                    print("error:", error)
            }).disposed(by: disposeBag)
    }

    private func updateDetailList() {
        self.detailModel[WeatherDetail.sunrise.rawValue].description = "\(weatherResult.sys?.sunrise ?? 0)"// TODO: Implement Time interval
        self.detailModel[WeatherDetail.sunset.rawValue].description = "\(weatherResult.sys?.sunset ?? 0)"
        self.detailModel[WeatherDetail.pressure.rawValue].description = "\(weatherResult.main?.pressure ?? 0)"
        self.detailModel[WeatherDetail.humidity.rawValue].description = "\(weatherResult.main?.humidity ?? 0)"
        self.detailModel[WeatherDetail.tempMin.rawValue].description = "\(weatherResult.main?.temp_min ?? 0)"
        self.detailModel[WeatherDetail.tempMax.rawValue].description = "\(weatherResult.main?.temp_max ?? 0)"
        self.detailModel[WeatherDetail.wind.rawValue].description = "\(weatherResult.wind?.speed ?? 0)"
        self.detailModel[WeatherDetail.visibility.rawValue].description = "\(weatherResult.visibility ?? 0)"
        
        self.detailSubject.onNext(detailModel)
    }

}