//
//  CityListHandlerProtocol.swift
//  WeatherZone
//
//  Created by Nischal Hada on 6/20/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import RxSwift

protocol CityListHandlerProtocol {
    func getCityInfo(withFilename fileName: String) -> Observable<[CityListModel]>
}
