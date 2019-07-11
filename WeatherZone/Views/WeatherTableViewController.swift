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
    private let disposeBag = DisposeBag()
    var viewModel: CityListViewModelProtocol = CityListViewModel()
    private var weatherList = [WeatherResult]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "City List"
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)

        self.viewModel.weatherList
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] list in
                self?.weatherList = list
                self?.tableView.reloadData()
            }, onError: { error in
                print("error:\(error)")
            })
            .disposed(by: disposeBag)
        self.viewModel.getWeatherInfo()
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
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
