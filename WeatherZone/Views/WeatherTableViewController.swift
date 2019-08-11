//
//  WeatherTableViewController.swift
//  WeatherZone
//
//  Created by Nischal Hada on 6/20/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WeatherTableViewController: UITableViewController {
    var viewModel: CityListViewModelProtocol = CityListViewModel()
    private var weatherList = [WeatherResult]()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "City List"
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.setupUI()

        self.viewModel.weatherList
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] list in
                self?.weatherList = list
                self?.tableView.reloadData()
            }, onError: { error in
                print("error:\(error)")
            })
            .disposed(by: disposeBag)
    }

    func setupUI() {
        self.tableView.backgroundColor = UIColor.viewBackgroundColor
        self.tableView.separatorStyle = .none
        self.tableView.hideEmptyCells()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityListTableViewCell", for: indexPath) as? CityListTableViewCell else {
            fatalError("CityListTableViewCell does not exist")
        }
        cell.model = self.weatherList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueWeatherDetail", sender: indexPath)
    }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "segueCitySearch" {
            guard let navC = segue.destination as? UINavigationController,
                let citySearchVC = navC.viewControllers.first as? CitySearchViewController else {
                    fatalError("Segue destination is not found")
            }

            citySearchVC
                .selectedCity?
                .observeOn(MainScheduler.asyncInstance)
                .subscribe(onNext: { [weak self] cityModel in
                    self?.viewModel.fetchWeatherFor(selectedCity: cityModel)
                    citySearchVC.dismiss(animated: true)
                })
            .disposed(by: disposeBag)
        } else if segue.identifier == "segueWeatherDetail" {

            guard let weatherDetailVC = segue.destination as? WeatherDetailViewController else {
                    fatalError("Segue destination is not found")
            }
            guard let indexPath = sender as? IndexPath else {
                fatalError("indexPath not found")
            }
            weatherDetailVC.weatherInfo = weatherList[indexPath.row]
        }

    }

}
