//
//  WeatherDetailViewController.swift
//  WeatherZone
//
//  Created by Nischal Hada on 9/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WeatherDetailViewController: UIViewController {

    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelCityTemperature: UILabel!
    @IBOutlet weak var labelMainName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    var weatherInfo: WeatherResult!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = weatherInfo.name
        setupUI()
        setView()
    }

    func setupUI() {
        self.view.backgroundColor = UIColor.viewBackgroundColor
        self.tableView.backgroundColor = UIColor.viewBackgroundColor
        self.tableView.separatorStyle = .none
        self.tableView.hideEmptyCells()
    }

    private func setView() {
        labelCityName.text = weatherInfo.name
        if let main = weatherInfo.main {
            labelCityTemperature.text = "\(main.temp) °C"
        }
        if
            let weather = weatherInfo.weather,
            weather.count > 0 {
            let weatherData = weather[0]

            let url = URL.iconURL(weatherData.icon)
            self.weatherImageView.kf.setImage(with: url)
            self.labelMainName.text = weatherData.main
            self.labelDescription.text = weatherData.description
        }

    }

}

// MARK: - TableViewDelegate Setup
extension WeatherDetailViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
            fatalError("Cell does not exist")
        }
        //        cell.dataValue = self.employeeList?.scheduled_today
        return cell    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
    }
}
