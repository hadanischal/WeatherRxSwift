//
//  CitySearchViewModelProtocol.swift
//  WeatherZone
//
//  Created by Nischal Hada on 4/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import RxSwift

protocol CitySearchViewModelProtocol {
    var cityList: Observable<[CityListModel]> { get }
    func getCityList()
    func searchCityWithName(withName name: Observable<String>)
    var isLoading: Observable<Bool> { get }
}
