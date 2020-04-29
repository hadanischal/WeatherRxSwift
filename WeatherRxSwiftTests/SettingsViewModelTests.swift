//
//  SettingsViewModelTests.swift
//  WeatherRxSwiftTests
//
//  Created by Nischal Hada on 21/2/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Cuckoo
import Nimble
import Quick
import RxSwift
import RxTest
@testable import WeatherRxSwift
import XCTest

final class SettingsViewModelTests: QuickSpec {
    override func spec() {
        var testViewModel: SettingsViewModel!
        var testScheduler: TestScheduler!
        var mockTemperatureUnitManager: MockTemperatureUnitManagerProtocol!

        describe("SettingsViewModel") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                mockTemperatureUnitManager = MockTemperatureUnitManagerProtocol()

                stub(mockTemperatureUnitManager) { stub in
                    when(stub.setTemperatureUnit(any())).thenDoNothing()
                }

                testViewModel = SettingsViewModel(mockTemperatureUnitManager,
                                                  backgroundScheduler: MainScheduler.instance)
            }

            describe("settingsList value is set properly") {
                it("sets the settings List value") {
                    let testObservable = testViewModel.settingsList
                    let res = testScheduler.start { testObservable }
                    expect(res.events.count).to(equal(2))
                    let correctResult = [Recorded.next(200, SettingsUnit.allCases),
                                         Recorded.completed(200)]
                    expect(res.events).to(equal(correctResult))
                }
            }

            describe("When user update Settings") {
                context("When user select celsius") {
                    beforeEach {
                        stub(mockTemperatureUnitManager) { stub in
                            when(stub.setTemperatureUnit(any())).thenDoNothing()
                        }
                        testViewModel.updateSettings(withUnit: .celsius)
                    }
                    it("update settings info in mockUserDefaultsManager") {
                        let argumentCaptor = ArgumentCaptor<SettingsUnit>()
                        verify(mockTemperatureUnitManager).setTemperatureUnit(argumentCaptor.capture())
                        expect(argumentCaptor.value).to(equal(SettingsUnit.celsius))
                    }
                }

                context("When user select fahrenheit") {
                    beforeEach {
                        stub(mockTemperatureUnitManager) { stub in
                            when(stub.setTemperatureUnit(any())).thenDoNothing()
                        }
                        testViewModel.updateSettings(withUnit: .fahrenheit)
                    }
                    it("update settings info in mockUserDefaultsManager") {
                        let argumentCaptor = ArgumentCaptor<SettingsUnit>()
                        verify(mockTemperatureUnitManager).setTemperatureUnit(argumentCaptor.capture())
                        expect(argumentCaptor.value).to(equal(SettingsUnit.fahrenheit))
                    }
                }
            }

            describe("When get Temprature unit if have set before") {
                context("When user select celsius") {
                    beforeEach {
                        stub(mockTemperatureUnitManager) { stub in
                            when(stub.getTemperatureUnit()).thenReturn(.celsius)
                        }
                    }
                    it("update settings info in mockUserDefaultsManager") {
                        _ = try? testViewModel.getTemperatureUnit().toBlocking(timeout: 2).toArray()
                        verify(mockTemperatureUnitManager).getTemperatureUnit()
                    }

                    it("returns selected index to be 0") {
                        let res = testScheduler.start { testViewModel.getTemperatureUnit() }
                        let correctResult = [Recorded.next(200, 0), Recorded.completed(200)]
                        expect(res.events.count).to(equal(2))
                        expect(res.events).to(equal(correctResult))
                    }
                }

                context("When user select fahrenheit") {
                    beforeEach {
                        stub(mockTemperatureUnitManager) { stub in
                            when(stub.getTemperatureUnit()).thenReturn(.fahrenheit)
                        }
                    }
                    it("update settings info in mockUserDefaultsManager") {
                        _ = try? testViewModel.getTemperatureUnit().toBlocking(timeout: 2).toArray()
                        verify(mockTemperatureUnitManager).getTemperatureUnit()
                    }
                    it("returns selected index to be 1") {
                        let res = testScheduler.start { testViewModel.getTemperatureUnit() }
                        let correctResult = [Recorded.next(200, 1), Recorded.completed(200)]
                        expect(res.events.count).to(equal(2))
                        expect(res.events).to(equal(correctResult))
                    }
                }
            }
        }
    }
}
