//
//  MockData.swift
//  WeatherRxSwiftTests
//
//  Created by Nischal Hada on 7/9/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherRxSwift

class MockData {

    func stubDetailModelList() -> [DetailModel] {
        let mockData = DetailModel(title: nil, description: nil)

        guard let data = self.readJson(forResource: "MockDetailList") else {
            XCTAssert(false, "Can't get data from MockDetailList.json")
            return [mockData]
        }

        let decoder = JSONDecoder()
        if let result = try? decoder.decode([DetailModel].self, from: data) {
            return result
        } else {
            XCTAssert(false, "Unable to parse DetailModel results")
            return [mockData]
        }
    }

    func stubWeatherResult() -> WeatherResult {
        let mockData = WeatherResult(main: nil, weather: nil, sys: nil, visibility: nil, wind: nil, name: nil)

        guard let data = self.readJson(forResource: "MockWeatherCity") else {
            XCTAssert(false, "Can't get data from MockWeatherCity.json")
            return mockData
        }

        let decoder = JSONDecoder()
        if let result = try? decoder.decode(WeatherResult.self, from: data) {
            return result
        } else {
            XCTAssert(false, "Unable to parse DetailModel results")
            return mockData
        }
    }

    func readJson(forResource fileName: String ) -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            XCTFail("Missing file: \(fileName).json")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            return data
        } catch _ {
            XCTFail("unable to read json")
            return nil
        }
    }

}
