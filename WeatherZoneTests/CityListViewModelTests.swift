//
//  CityListViewModelTests.swift
//  WeatherZoneTests
//
//  Created by Nischal Hada on 7/9/19.
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

class CityListViewModelTests: QuickSpec {

    override func spec() {
        var testViewModel: CityListViewModel!
        var mockCityListHandler: MockCityListHandlerProtocol!
        var mockGetWeatherHandler: MockGetWeatherHandlerProtocol!
        var testScheduler: TestScheduler!

        describe("CityListViewModel") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                mockCityListHandler = MockCityListHandlerProtocol()
                stub(mockCityListHandler, block: { stub in
                    when(stub.getCityInfo(withFilename: any())).thenReturn(Observable.just([cityList]))
                })
                mockGetWeatherHandler = MockGetWeatherHandlerProtocol()
                stub(mockGetWeatherHandler, block: { stub in
                    when(stub.getWeatherInfo(by: any())).thenReturn(Observable.just(weatherResult))
                    when(stub.getWeatherInfo(byCityIDs: any())).thenReturn(Observable.just(citysWeatherResult))
                })
                testViewModel = CityListViewModel(withCityList: mockCityListHandler, withGetWeather: mockGetWeatherHandler)
            }

            describe("Get weather List from server", {

                context("when server request succeed ", {
                    beforeEach {
                        stub(mockCityListHandler, block: { stub in
                            when(stub.getCityInfo(withFilename: any())).thenReturn(Observable.just([cityList]))
                        })
                        stub(mockGetWeatherHandler, block: { stub in
                            when(stub.getWeatherInfo(byCityIDs: any())).thenReturn(Observable.just(citysWeatherResult))
                        })
                        testViewModel.getWeatherInfo()
                    }
                    it("calls to the CityListHandler to get city info", closure: {
                        verify(mockCityListHandler).getCityInfo(withFilename: any())
                    })
                    it("calls to the GetWeatherHandler to get weather info", closure: {
                        verify(mockGetWeatherHandler).getWeatherInfo(byCityIDs: any())
                    })
                })

                it("emits the weatherList to the UI", closure: {
                    testScheduler.scheduleAt(300, action: {
                        testViewModel.getWeatherInfo()
                    })
                    let res = testScheduler.start { testViewModel.weatherList.asObservable() }
                    expect(res.events.count).to(equal(1))
                    expect(res.events.first?.time).to(equal(300))
                    expect(res.events.last?.time).to(equal(300))
                })

                context("when get city info request failed ", {
                    beforeEach {
                        stub(mockCityListHandler, block: { stub in
                            when(stub.getCityInfo(withFilename: any())).thenReturn(Observable.error(RxError.noElements))
                        })
                    }
                    it("doesnt emits weather list to the UI", closure: {
                        testScheduler.scheduleAt(300, action: {
                            testViewModel.getWeatherInfo()
                        })
                        let res = testScheduler.start { testViewModel.weatherList.asObservable() }
                        expect(res.events).to(beEmpty())
                    })
                })

                context("when server request failed for get weather info", {
                    beforeEach {

                        stub(mockCityListHandler, block: { stub in
                            when(stub.getCityInfo(withFilename: any())).thenReturn(Observable.just([cityList]))
                        })
                        stub(mockGetWeatherHandler, block: { stub in
                            when(stub.getWeatherInfo(byCityIDs: any())).thenReturn(Observable.error(RxError.noElements))
                        })
                    }
                    it("doesnt emits weatherList to the UI", closure: {
                        testScheduler.scheduleAt(300, action: {
                            testViewModel.getWeatherInfo()
                        })
                        let res = testScheduler.start { testViewModel.weatherList.asObservable() }
                        expect(res.events).to(beEmpty())
                    })
                })

            })

        }
    }
}

private let coord = Coord(lon: 12.00, lat: 11.00)
private let cityList = CityListModel(id: 1, name: "Bob", coord: coord, country: "Dream Land")

private let weather = Weather(temp: 12.00, humidity: 11.0)
private let weatherResult = WeatherResult(main: weather, name: "Gloomy Day")

private let citysWeatherResult = CityWeatherModel(cnt: 1, list: [weatherResult])
