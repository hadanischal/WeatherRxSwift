//
//  CityListHandler.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 6/20/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class CityListHandler: CityListHandlerProtocol {

    func getCityInfo(withFilename fileName: String) -> Observable<[CityListModel]> {
        return Observable<[CityListModel]>.create { observer in

            guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
                observer.on(.error(RxError.noElements))
                return Disposables.create {}
            }

            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([CityListModel].self, from: data)
                observer.on(.next(jsonData))
                observer.on(.completed)
            } catch let error {
                print("error: \(error)")
                observer.on(.error(error))
            }
            return Disposables.create()
        }
    }
}
