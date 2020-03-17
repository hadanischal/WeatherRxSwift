//
//  URLRequest+Extensions.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 6/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

struct Resource<T> {
    let url: URL
    var parameter: [String: String]?
}

extension URLRequest {

    static func load<T: Decodable>(resource: Resource<T>) -> Observable<T> {
        return Observable.just(resource.url)
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.response(request: request)
        }.map { response, data -> T in

            if 200..<300 ~= response.statusCode {
                return try JSONDecoder().decode(T.self, from: data)
            } else {
                throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
            }

        }.asObservable()

    }

    static func loadWithPayLoad<T: Decodable>(resource: Resource<T>) -> Observable<T> {
        return Observable.just(resource.url)
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                let request = URLRequest(url: self.loadURL(resource: resource) ?? url)
                return URLSession.shared.rx.response(request: request)
        }.map { response, data -> T in

            if 200..<300 ~= response.statusCode {
                return try JSONDecoder().decode(T.self, from: data)
            } else {
                throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
            }

        }.asObservable()

    }

    static func loadURL<T>(resource: Resource<T>) -> URL? {
        if
            let parameters = resource.parameter,
            let urlComponents = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
        {
            var components = urlComponents
            components.queryItems = parameters.map { (arg) -> URLQueryItem in
                let (key, value) = arg
                return URLQueryItem(name: key, value: value)
            }
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            return components.url
        }
        return nil
    }

}

    /*
    static func load<T: Decodable>(resource: Resource<T>) -> Observable<T> {
        return Observable.from([resource.url])
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }.asObservable()
    }
*/
