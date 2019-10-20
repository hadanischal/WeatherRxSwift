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
import CocoaLumberjack

class WeatherTableViewController: UITableViewController {
    var viewModel: CityListViewModelProtocol = CityListViewModel()
    private var weatherList = [WeatherResult]()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }

    func setupUI() {
        title = "City List"
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        navigationController?.setCustomStyle()
        tableView.backgroundColor = UIColor.viewBackgroundColor
        tableView.separatorStyle = .none
        tableView.hideEmptyCells()
    }

    func setupViewModel() {
        self.viewModel.weatherList
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] list in
                self?.weatherList = list
                self?.tableView.reloadData()
                }, onError: { error in
                    DDLogError("onError: \(error)")
            })
            .disposed(by: disposeBag)

        let appName = Bundle.main.displayName ?? "This app"

        self.viewModel.errorMessage
        .asDriver(onErrorJustReturn: "")
            .drive(onNext: { [weak self] message in
                self?.showAlertView(withTitle: appName, andMessage: message)
            }).disposed(by: disposeBag)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CityListTableViewCell
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
                    citySearchVC.dismiss(animated: true)
                    self?.viewModel.fetchWeatherFor(selectedCity: cityModel)
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
