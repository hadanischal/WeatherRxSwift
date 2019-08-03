//
//  WeatherViewModelTests.swift
//  WeatherZoneTests
//
//  Created by Nischal Hada on 7/11/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Cuckoo
import RxTest
import RxBlocking
import RxSwift
@testable import WeatherZone

class WeatherViewModelTests: QuickSpec {

    override func spec() {
        var testViewModel: WeatherViewModel!
        var mockGetWeatherHandler: MockGetWeatherHandlerProtocol!
        var testScheduler: TestScheduler!

        describe("WeatherViewModel") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                mockGetWeatherHandler = MockGetWeatherHandlerProtocol()
                stub(mockGetWeatherHandler, block: { stub in
                    when(stub.getWeatherInfo(by: any())).thenReturn(Observable.just(weatherResult))
                    when(stub.getWeatherInfo(byCityIDs: any())).thenReturn(Observable.just(citysWeatherResult))
                })
                testViewModel = WeatherViewModel(withGetWeather: mockGetWeatherHandler)
            }

            describe("Get weather List from server", {

                context("when server request succeed ", {
                    beforeEach {
                        stub(mockGetWeatherHandler, block: { stub in
                            when(stub.getWeatherInfo(byCityIDs: any())).thenReturn(Observable.just(citysWeatherResult))
                        })
                        testViewModel.getWeatherInfo(by: "Sydney")
                    }

                    it("calls to GetWeatherHandler to get weather info", closure: {
                        verify(mockGetWeatherHandler).getWeatherInfo(by: any())
                    })
                })

                it("emits the weatherList to the UI", closure: {
                    testScheduler.scheduleAt(300, action: {
                        testViewModel.getWeatherInfo(by: "Sydney")
                    })
                    let res = testScheduler.start { testViewModel.weatherList.asObservable() }
                    expect(res.events.count).to(equal(1))
                    expect(res.events.first?.time).to(equal(300))
                    expect(res.events.last?.time).to(equal(300))
                })

                context("when server request failed for get weather info", {
                    beforeEach {
                        stub(mockGetWeatherHandler, block: { stub in
                            when(stub.getWeatherInfo(by: any())).thenReturn(Observable.error(RxError.noElements))
                            when(stub.getWeatherInfo(byCityIDs: any())).thenReturn(Observable.error(RxError.noElements))
                        })
                    }
                    it("doesnt emits weatherList to the UI", closure: {
                        testScheduler.scheduleAt(300, action: {
                            testViewModel.getWeatherInfo(by: "Sydney")
                        })
                        let res = testScheduler.start { testViewModel.weatherList.asObservable() }
                        expect(res.events.count).to(equal(1))
                        expect(res.events.first?.time).to(equal(300))
                        expect(res.events.last?.time).to(equal(300))
//                        expect(res.events).to(beEmpty())
                    })
                })

            })

        }
    }
}

private let mainModel = MainModel(temp: 12.00, pressure: 11.00, humidity: 10.00, temp_min: 9.00, temp_max: 15.00)
private let weatherResult = WeatherResult(main: mainModel, name: "Sydney")
private let weatherResultEmpty = WeatherResult.empty
//private let weatherEmpty: Weather? = Weather(temp: 12.00, humidity: 11.0)
private let citysWeatherResult = CityWeatherModel(cnt: 1, list: [weatherResult])
