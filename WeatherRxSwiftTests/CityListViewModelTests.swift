//
//  CityListViewModelTests.swift
//  WeatherRxSwiftTests
//
//  Created by Nischal Hada on 21/3/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Cuckoo
import RxTest
import RxBlocking
import RxSwift
@testable import WeatherRxSwift

//swiftlint:disable function_body_length
class CityListViewModelTests: QuickSpec {
    
    override func spec() {
        var testViewModel: CityListViewModel!
        var mockCityListHandler: MockCityListInteracting!
        var mockTemperatureUnitManager: MockTemperatureUnitManagerProtocol!
        var testScheduler: TestScheduler!
        
        describe("CityListViewModel") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                
                mockCityListHandler = MockCityListInteracting()
                stub(mockCityListHandler) { stub in
                    when(stub.getCityListFromFile()).thenReturn(Observable.error(RxError.noElements))
                    when(stub.getWeatherInfo(forCity: any())).thenReturn(Observable.just(MocksInfo.weatherResult))
                    when(stub.getWeatherInfo(forCityList: any())).thenReturn(Observable.just([MocksInfo.weatherResult]))
                }
                
                mockTemperatureUnitManager = MockTemperatureUnitManagerProtocol()
                stub(mockTemperatureUnitManager) { stub in
                    when(stub.setTemperatureUnit(any())).thenDoNothing()
                }
                
                testViewModel = CityListViewModel(withCityList: mockCityListHandler,
                                                  temperatureManager: mockTemperatureUnitManager)
            }
            
            describe("Get WeatherInfo for cityList from server") {
                context("when server request completes successfully") {
                    beforeEach {
                        stub(mockCityListHandler) { stub in
                            when(stub.getCityListFromFile()).thenReturn(Observable.just([MocksInfo.cityList]))
                            when(stub.getWeatherInfo(forCityList: any())).thenReturn(Observable.just([MocksInfo.weatherResult]))
                        }
                        testViewModel.getWeatherInfoForCityList()
                    }
                    it("calls to the mockGetWeatherHandler to get weather info") {
                        let argumentCaptor = ArgumentCaptor<[CityListModel]>()
                        verify(mockCityListHandler).getWeatherInfo(forCityList: argumentCaptor.capture())
                        expect(argumentCaptor.value).to(equal([MocksInfo.cityList]))
                    }
                    it("emits weather list to the UI to update list") {
                        let res = testScheduler.start { testViewModel.weatherList.asObservable() }
                        expect(res.events.count).to(equal(1))
                        let correctResult = [Recorded.next(200, [MocksInfo.weatherResult])]
                        expect(res.events).to(equal(correctResult))
                    }
                }
                
                context("when server request fails with error") {
                    beforeEach {
                        stub(mockCityListHandler) { stub in
                            when(stub.getCityListFromFile()).thenReturn(Observable.just([MocksInfo.cityList]))
                            when(stub.getWeatherInfo(forCityList: any())).thenReturn(Observable.error(testError1))
                        }
                        
                        testViewModel.getWeatherInfoForCityList()
                    }
                    it("calls to the mockGetWeatherHandler to get weather info") {
                        let argumentCaptor = ArgumentCaptor<[CityListModel]>()
                        verify(mockCityListHandler).getWeatherInfo(forCityList: argumentCaptor.capture())
                        expect(argumentCaptor.value).to(equal([MocksInfo.cityList]))
                    }
                    it("emits weather list to the UI to update list") {
                        let res = testScheduler.start { testViewModel.weatherList.asObservable() }
                        expect(res.events.count).to(equal(1))
                        let correctResult: [Recorded<Event<[WeatherResult]>>] = [Recorded.next(200, [])]
                        expect(res.events).to(equal(correctResult))
                    }
                }
            }
            
            describe("fetch weather info for selected city from server") {
                context("when server request succeed") {
                    beforeEach {
                        stub(mockCityListHandler) { stub in
                            when(stub.getWeatherInfo(forCity: any())).thenReturn(Observable.just(MocksInfo.weatherResult))
                        }
                        testViewModel.fetchWeatherFor(selectedCity: MocksInfo.cityList)
                    }
                    it("calls to the mockGetWeatherHandler to get weather info") {
                        let argumentCaptor = ArgumentCaptor<CityListModel>()
                        verify(mockCityListHandler).getWeatherInfo(forCity: argumentCaptor.capture())
                        expect(argumentCaptor.value).to(equal(MocksInfo.cityList))
                    }
                    it("emits weather list to the UI to update list") {
                        let res = testScheduler.start { testViewModel.weatherList.asObservable() }
                        expect(res.events.count).to(equal(1))
                        let correctResult = [Recorded.next(200, [MocksInfo.weatherResult])]
                        expect(res.events).to(equal(correctResult))
                    }
                }
                
                context("when server request failed") {
                    beforeEach {
                        stub(mockCityListHandler) { stub in
                            when(stub.getWeatherInfo(forCity: any())).thenReturn(Observable.error(testError1))
                        }
                        testViewModel.fetchWeatherFor(selectedCity: MocksInfo.cityList)
                    }
                    it("calls to the mockGetWeatherHandler to get weather info") {
                        let argumentCaptor = ArgumentCaptor<CityListModel>()
                        verify(mockCityListHandler).getWeatherInfo(forCity: argumentCaptor.capture())
                        expect(argumentCaptor.value).to(equal(MocksInfo.cityList))
                    }
                    it("emits weather list to the UI to update list") {
                        let res = testScheduler.start { testViewModel.weatherList.asObservable() }
                        expect(res.events.count).to(equal(1))
                        let correctResult: [Recorded<Event<[WeatherResult]>>] = [Recorded.next(200, [])]
                        expect(res.events).to(equal(correctResult))
                    }
                }
            }
            
            describe("When get Temprature unit if have set before") {
                context("When user select celsius") {
                    var result: SettingsUnit!
                    beforeEach {
                        stub(mockTemperatureUnitManager) { stub in
                            when(stub.getTemperatureUnit()).thenReturn(.celsius)
                        }
                        result = testViewModel.temperatureUnit
                    }
                    it("update settings info in mockUserDefaultsManager") {
                        verify(mockTemperatureUnitManager).getTemperatureUnit()
                    }
                    
                    it("returns selected index to be 0") {
                        expect(result).to(equal(.celsius))
                    }
                }
                
                context("When user select fahrenheit") {
                    var result: SettingsUnit!
                    beforeEach {
                        stub(mockTemperatureUnitManager) { stub in
                            when(stub.getTemperatureUnit()).thenReturn(.fahrenheit)
                        }
                        result = testViewModel.temperatureUnit
                    }
                    it("update settings info in mockUserDefaultsManager") {
                        verify(mockTemperatureUnitManager).getTemperatureUnit()
                    }
                    it("returns selected index to be 0") {
                        expect(result).to(equal(.fahrenheit))
                    }
                }
            }
        }
    }
}
