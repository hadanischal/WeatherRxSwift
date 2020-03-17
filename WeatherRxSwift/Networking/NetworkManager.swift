//
//  NetworkManager.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 14/3/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import RxSwift

protocol NetworkingManager {
    func load<T: Decodable>(resource: Resource<T>) -> Observable<T>
}

final class NetworkManager: NetworkingManager {
    func load<T: Decodable>(resource: Resource<T>) -> Observable<T> {
        if resource.parameter != nil {
            return URLRequest.loadWithPayLoad(resource: resource)
        } else {
            return URLRequest.load(resource: resource)
        }
    }
}
