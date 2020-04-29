//
//  SettingsTableViewController.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 12/3/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class SettingsTableViewController: UITableViewController {
    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var doneButton: UIBarButtonItem!
    private var viewModel: SettingsDataSource!
    private var settingsList: [SettingsUnit] = []
    private let disposeBag = DisposeBag()
    var completionHandlers: (() -> Void)?

    convenience init(withDataSource dataSource: SettingsDataSource) {
        self.init()
        self.viewModel = dataSource
    }

    static func settingsVC(_ viewModel: SettingsDataSource = SettingsViewModel()) -> SettingsTableViewController {
        let viewController = StoryboardScene.SettingsStoryboard.settingsTableViewController.instantiate()
        viewController.viewModel = viewModel
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        configureTableView()
        setupViewModel()
    }

    private func setUpUI() {
        title = "Select Settings"
        navigationController?.setCustomStyle()
    }

    private func configureTableView() {
        tableView?.backgroundColor = UIColor.viewBackgroundColor
        view.backgroundColor = UIColor.viewBackgroundColor
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(SettingsTableViewCell.self)
        tableView.estimatedRowHeight = 160
        tableView.rowHeight = UITableView.automaticDimension
    }

    private func setupViewModel() {
        viewModel.settingsList
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] result in
                self?.settingsList = result
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)

        viewModel.getTemperatureUnit()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] row in
                self?.configureSelectedRow(row)
            }).disposed(by: disposeBag)
    }

    private func configureSelectedRow(_ row: Int) {
        let indexPath = IndexPath(item: row, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
    }

    // MARK: - Button Action

    @IBAction func actionCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    @IBAction func actionDone(_ sender: UIBarButtonItem) {
        guard let row = tableView.indexPathForSelectedRow?.row else {
            showAlertView(withTitle: "Unable to get selected unit", andMessage: "Please select the Unit")
            return
        }

        let selectedValue = settingsList[row]
        viewModel.updateSettings(withUnit: selectedValue)

        self.dismiss(animated: true, completion: { [weak self] in
            self?.completionHandlers?()
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as SettingsTableViewCell
        cell.configure(settingsList[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
}
