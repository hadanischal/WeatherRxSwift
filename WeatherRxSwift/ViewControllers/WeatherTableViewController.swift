//
//  WeatherTableViewController.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 6/20/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class WeatherTableViewController: UITableViewController {
    var viewModel: CityListDataSource = CityListViewModel()
    private var weatherList = [WeatherResult]()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
        setupViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func configureView() {
        navigationController?.setCustomStyle()
        navigationItem.title = L10n.DashBoard.titleCityList
    }

    private func configureTableView() {
        tableView?.backgroundColor = UIColor.viewBackgroundColor
        view.backgroundColor = UIColor.viewBackgroundColor
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorStyle = .none
        tableView.hideEmptyCells()
        tableView.register(CitySearchTableViewCell.self)
    }

    private func setupViewModel() {
        self.viewModel.weatherList
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] list in
                self?.weatherList = list
                self?.tableView.reloadData()
            }, onError: { error in
                print("onError: \(error)")
            })
            .disposed(by: disposeBag)

        self.viewModel.errorMessage
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { [weak self] message in
                self?.showAlertView(withTitle: Bundle.main.displayName, andMessage: message)
            }).disposed(by: disposeBag)

        self.viewModel.getWeatherInfoForCityList()
    }

    @IBAction func actionSearch(_ sender: UIBarButtonItem) {
        let citySearchViewModel = CitySearchViewModel()
        let viewController = CitySearchViewController.citySearchVC(citySearchViewModel)
        let navigationController = NavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        viewController.completionHandlers = { [weak self] cityModel in
            self?.viewModel.fetchWeatherFor(selectedCity: cityModel)
        }
        self.present(navigationController, animated: true)
    }

    @IBAction func actionSettings(_ sender: Any) {
        let settingsViewModel = SettingsViewModel()
        let viewController = SettingsTableViewController.settingsVC(settingsViewModel)
        let navigationController = NavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        viewController.completionHandlers = { [weak self] in
            self?.viewModel.getWeatherInfoForCityList()
        }
        self.present(navigationController, animated: true)
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
        cell.configure(viewModel.getWeatherDataModel(for: weatherList[indexPath.row]))
        cell.selectionStyle = .none
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handellNavigation(indexPath)
    }

    private func handellNavigation(_ indexPath: IndexPath) {
        let detailViewModel = WeatherDetailViewModel(withWeatherResultModel: weatherList[indexPath.row])
        let viewController = WeatherDetailViewController.weatherDetailVC(detailViewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let storyboardSegue = StoryboardSegue.Main(segue) else { return }

        switch storyboardSegue {
        case .segueCitySearch, .segueWeatherListView, .segueWeatherDetail:
            break
        }
    }
}
