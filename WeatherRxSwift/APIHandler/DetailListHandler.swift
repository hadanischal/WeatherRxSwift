//
//  DetailListHandler.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 11/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailListHandler: DetailListHandlerProtocol {
    init() {}

    func getDetailInfo(withFilename fileName: String) -> Observable<[DetailModel]> {
        return Observable<[DetailModel]>.create { observer in
            if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([DetailModel].self, from: data)
                    observer.on(.next(jsonData))
                    observer.on(.completed)
                } catch let error {
                    print("error : \(error)")
                    observer.on(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
