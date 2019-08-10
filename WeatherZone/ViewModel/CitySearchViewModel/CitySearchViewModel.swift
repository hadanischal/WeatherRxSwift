//
//  CitySearchViewModel.swift
//  WeatherZone
//
//  Created by Nischal Hada on 4/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift

class CitySearchViewModel: CitySearchViewModelProtocol {
    //input
    private let cityListHandler: CityListHandlerProtocol
    private let backgroundScheduler: SchedulerType

    //output
    var cityList: Observable<[CityListModel]>
    private let cityListSubject = PublishSubject<[CityListModel]>()
    private var localCityList: [CityListModel]
    private let disposeBag = DisposeBag()

    init(withCityList cityListHandler: CityListHandlerProtocol = CityListHandler(),
         withSchedulerType backgroundScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)
        ) {
        self.cityListHandler = cityListHandler
        self.backgroundScheduler = backgroundScheduler

        self.cityList = cityListSubject.asObservable()
        self.localCityList = []
        self.getCityList()
    }

    func getCityList() {
        self.cityListHandler
            .getCityInfo(withFilename: "cityList")
            .subscribeOn(backgroundScheduler)
            .subscribe(onNext: { [weak self] cityList in
                self?.cityListSubject.onNext(cityList)
                self?.localCityList = cityList
                }, onError: { error in
                    print("error:", error)
            }).disposed(by: disposeBag)
    }

    func searchCityWithName(withName name: Observable<String>) {
        name
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] searchQuery in
                if searchQuery.isEmpty {
                    self?.cityListSubject.onNext([])
                } else {
                    self?.filterCityname(withCityName: searchQuery)
                }
            }).disposed(by: disposeBag)
    }

    private func filterCityname(withCityName cityName: String) {
        let foundItems = self.localCityList.filter { (($0.name?.range(of: cityName)) != nil) || $0.id == Int(cityName) }
        self.cityListSubject.onNext(foundItems)
    }
}
