//
//  WeatherDetailViewController.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 9/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class WeatherDetailViewController: UIViewController {
    @IBOutlet var labelCityName: UILabel!
    @IBOutlet var labelCityTemperature: UILabel!
    @IBOutlet var labelMainName: UILabel!
    @IBOutlet var labelDescription: UILabel!
    @IBOutlet var weatherImageView: UIImageView!
    @IBOutlet var tableView: UITableView!

    private var viewModel: WeatherDetailDataSource!
    private var detailList = [DetailModel]()
    private let disposeBag = DisposeBag()

    convenience init(withDataSource dataSource: WeatherDetailDataSource) {
        self.init()
        self.viewModel = dataSource
    }

    static func weatherDetailVC(_ viewModel: WeatherDetailDataSource) -> WeatherDetailViewController {
        let viewController = StoryboardScene.Main.weatherDetailViewController.instantiate()
        viewController.viewModel = viewModel
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupViewModel()
        updateView()
    }

    private func configureView() {
        self.view.backgroundColor = UIColor.viewBackgroundColor
        self.tableView.backgroundColor = UIColor.viewBackgroundColor
        self.tableView.hideEmptyCells()
    }

    private func setupViewModel() {
        viewModel.title.bind(to: navigationItem.rx.title).disposed(by: disposeBag)

        viewModel.detailList
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] list in
                self?.detailList = list
                self?.tableView.reloadData()
            }).disposed(by: disposeBag)

        viewModel.getDetailResult()
    }

    private func updateView() {
        guard let data = viewModel.weatherDataModel else { return }
        labelCityName.text = data.cityName
        labelCityTemperature.text = data.temperature
        weatherImageView.setImage(url: data.iconURL)
        labelMainName.text = data.mainName
        labelDescription.text = data.description

        labelCityName.textColor = .titleColor
        labelCityTemperature.textColor = .descriptionColor
        labelMainName.textColor = .titleColor
        labelDescription.textColor = .descriptionColor
    }
}

// MARK: - TableViewDelegate Setup

extension WeatherDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as WeatherDetailTableViewCell
        cell.configure(detailList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
    }
}
