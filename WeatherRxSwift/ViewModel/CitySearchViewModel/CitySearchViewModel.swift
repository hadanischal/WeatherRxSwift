//
//  CitySearchViewModel.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 4/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class CitySearchViewModel: CitySearchViewModelProtocol {
    //input
    private let cityListHandler: CityListHandlerProtocol
    private let backgroundScheduler: SchedulerType

    //output
    var cityList: Observable<[CityListModel]>
    var isLoading: Observable<Bool>

    private let cityListSubject = PublishSubject<[CityListModel]>()
    private let loadingSubject = BehaviorRelay<Bool>(value: true)

    private var localCityList: [CityListModel]
    private let disposeBag = DisposeBag()

    init(withCityList cityListHandler: CityListHandlerProtocol = CityListHandler(),
         withSchedulerType backgroundScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)
        ) {
        self.cityListHandler = cityListHandler
        self.backgroundScheduler = backgroundScheduler

        self.cityList = cityListSubject.asObservable()
        self.localCityList = []
        self.isLoading = loadingSubject.asObservable()

//        self.getCityList()
    }

    func getCityList() {
        self.loadingSubject.accept(true)

        self.cityListHandler
            .getCityInfo(withFilename: "cityList")
            .subscribeOn(backgroundScheduler)
            .subscribe(onNext: { [weak self] cityList in
                self?.cityListSubject.onNext(cityList)
                self?.localCityList = cityList
                self?.loadingSubject.accept(false)
                }, onError: { error in
                    print("onError: \(error)")
            }).disposed(by: disposeBag)
    }

    func searchCityWithName(withName name: Observable<String>) {
        self.loadingSubject.accept(true)

        name
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] searchQuery in
                self?.loadingSubject.accept(false)

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
