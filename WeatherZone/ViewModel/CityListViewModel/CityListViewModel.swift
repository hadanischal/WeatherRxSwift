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
    private let disposeBag = DisposeBag()
    var cityList: Observable<[CityListModel]>
    
    private let cityListSubject = PublishSubject<[CityListModel]>()
    
    init(withCityList cityListHandler: CityListHandlerProtocol = CityListHandler()) {
        self.cityListHandler = cityListHandler
        self.cityList = cityListSubject.asObserver()
    }
    
    func getCityInfo() {
        self.cityListHandler
        .getCityInfo(withFilename: "StartCity")
            .subscribe(onNext: { [weak self] result in
                self?.cityListSubject.on(.next(result))
                }, onError: { error in
                    print("VM error :", error)
            })
        .disposed(by: disposeBag)
    }
}
