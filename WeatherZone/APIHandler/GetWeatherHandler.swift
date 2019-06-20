//
//  GetWeatherHandler.swift
//  WeatherZone
//
//  Created by Nischal Hada on 6/20/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GetWeatherHandler: GetWeatherHandlerProtocol {
    init() {}
    
    func getWeatherInfo(by city: String) -> Observable<WeatherResult?> {
        
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let url = URL.urlForWeatherAPI(city: cityEncoded) else { return Observable<WeatherResult?>.error(RxError.noElements) }
        
        let resource = Resource<WeatherResult>(url: url)
        return URLRequest.load(resource: resource)
            .map{ article -> WeatherResult? in
                return article
            }.asObservable()
            .retry(2)
    }
    
}


