//
//  DetailListHandlerProtocol.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 11/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import RxSwift

protocol DetailListHandlerProtocol {
    func getDetailInfo(withFilename fileName: String) -> Observable<[DetailModel]>
}
