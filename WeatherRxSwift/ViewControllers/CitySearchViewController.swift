//
//  CitySearchViewController.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 4/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class CitySearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    var completionHandlers: ((CityListModel) -> Void)?

    private var cityList = [CityListModel]()
    private var viewModel: CitySearchDataSource!
    private let disposeBag = DisposeBag()

    convenience init(withDataSource dataSource: CitySearchDataSource) {
        self.init()
        self.viewModel = dataSource
    }

    static func citySearchVC(_ viewModel: CitySearchDataSource = CitySearchViewModel()) -> CitySearchViewController {
        let viewController = StoryboardScene.Main.citySearchViewController.instantiate()
        viewController.viewModel = viewModel
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
        configureViewModel()
    }

    private func configureView() {
        navigationController?.setCustomStyle()
        navigationItem.title = L10n.DashBoard.titleSearchCity
        //change UISearchBar font
        UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont.body2
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont.body2
    }

    private func configureTableView() {
        tableView?.backgroundColor = UIColor.viewBackgroundColor
        view.backgroundColor = UIColor.viewBackgroundColor
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(CitySearchTableViewCell.self)
        tableView.estimatedRowHeight = 160
        tableView.rowHeight = UITableView.automaticDimension
        tableView.hideEmptyCells()
    }

    private func configureViewModel() {
        viewModel.cityList
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] list in
                self?.cityList = list
                self?.tableView?.reloadData()
            }).disposed(by: disposeBag)

        viewModel.isLoading.bind(to: activityIndicatorView.rx.isAnimating).disposed(by: disposeBag)

        let searchQuery = searchBar.rx.text.orEmpty.asObservable()
        viewModel.searchCityWithName(withName: searchQuery)
        viewModel.getCityList()
    }

    // MARK: - Button Action

    @IBAction func actionCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cityList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CitySearchTableViewCell
        cell.configure(cityList[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.completionHandlers?(self.cityList[indexPath.row])
        }
    }
}
