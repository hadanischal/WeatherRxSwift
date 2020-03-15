//
//  SettingsViewModel.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 12/2/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation
import RxSwift

protocol SettingsDataSource: class {
    var isUpdated: Observable<()> { get }
    var settingsList: Observable<[SettingsUnit]> { get }
    func updateSettings(withUnit unit: SettingsUnit)
    func getTemperatureUnit() -> Observable<Int>
}

final class SettingsViewModel: SettingsDataSource {

    let isUpdated: Observable<()>
    var settingsList: Observable<[SettingsUnit]> { return Observable.just(SettingsUnit.allCases) }

    private let temperatureUnitManager: TemperatureUnitManagerProtocol
    private let backgroundScheduler: SchedulerType

    private let isUpdatedSubject = PublishSubject<()>()
    private var unitList: [String] = SettingsUnit.allCases.map { $0.rawValue}

    init(_ userDefaultsManager: TemperatureUnitManagerProtocol = TemperatureUnitManager(),
         backgroundScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: DispatchQoS.utility)) {
        self.temperatureUnitManager = userDefaultsManager
        self.backgroundScheduler = backgroundScheduler
        self.isUpdated = isUpdatedSubject.asObservable()
    }

    func updateSettings(withUnit unit: SettingsUnit) {
        temperatureUnitManager.setTemperatureUnit(unit)
        isUpdatedSubject.onNext(())
    }

    func getTemperatureUnit() -> Observable<Int> {
        return settingsList
            .flatMap { [weak self] list -> Observable<Int?> in
                guard let self = self else { return Observable.empty()}
                let unit = self.temperatureUnitManager.getTemperatureUnit()
                let index = list.firstIndex(of: unit)
                return Observable.just(index)
        }
        .compactMap { $0 }
        .subscribeOn(backgroundScheduler)
    }
}
