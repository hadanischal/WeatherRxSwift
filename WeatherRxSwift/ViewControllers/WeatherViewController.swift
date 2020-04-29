//
//  WeatherViewController.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 6/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class WeatherViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var viewModel: WeatherViewModelProtocol = WeatherViewModel()

    @IBOutlet var cityNameTextField: UITextField!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupViewModel()
    }

    private func setupUI() {
        self.view.backgroundColor = UIColor.viewBackgroundColor
        self.title = viewModel.title
    }

    private func setupViewModel() {
        self.viewModel.weatherList
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] weather in
                self?.displayWeather(weather)
            }, onError: { error in
                print("onError: \(error)")
            })
            .disposed(by: disposeBag)

        self.cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map { self.cityNameTextField.text }
            .subscribe(onNext: { city in

                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.viewModel.getWeatherInfo(by: city)
                    }
                }

            }).disposed(by: disposeBag)
    }

    private func displayWeather(_ weather: WeatherResult?) {
        if let weather = weather?.main {
            self.temperatureLabel.text = "\(weather.temp) °C"
            self.humidityLabel.text = "\(weather.humidity) 💦"
        } else {
            self.temperatureLabel.text = "🙈"
            self.humidityLabel.text = "⦰"
        }
    }
}
