//
//  DetailMealViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

final class DetailMealViewController: BaseViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    var viewModel: DetailMealViewModel = DetailMealViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func setUpUI() {
        configNavi()
        registerTableCell()
    }

    override func setUpData() {
        DispatchQueue.global(qos: .userInitiated).async {
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            self.loadAPIDetail {
                dispatchGroup.leave()
            }
            dispatchGroup.enter()
            self.loadAPIRandomMeal {
                dispatchGroup.leave()
            }
            dispatchGroup.notify(queue: .main) { }
        }
    }

    // MARK: - Private Functions
    private func configNavi() {

    }


    private func loadAPIDetail(completion: @escaping() -> Void) {
        HUD.show()
        viewModel.getAPIDetailMeal { [weak self] (done, msg) in
            HUD.dismiss()
            guard let self = self else {
                return
            }
            if done {
                self.updateView()
            } else {
                self.showAlert(message: msg)
            }
        }
    }

    private func loadAPIRandomMeal(completion: @escaping() -> Void) {
        viewModel.getAPIRandomMeal { (done, msg) in
            if done {
                self.updateView()
            } else {
                self.showAlert(message: msg)
            }
        }
    }

    private func registerTableCell() {
        tableView.register(nibWithCellClass: ImageTableViewCell.self)
        tableView.register(nibWithCellClass: InfoTableViewCell.self)
        tableView.register(nibWithCellClass: VideoTableViewCell.self)
        tableView.register(nibWithCellClass: InstructionsTableViewCell.self)
        tableView.register(nibWithCellClass: IngredientMeasureTableViewCell.self)
        tableView.register(nibWithCellClass: SourceLinkTableViewCell.self)
        tableView.register(nibWithCellClass: OtherFoodTableViewCell.self)
        tableView.dataSource = self
    }

    private func updateView() {
        guard isViewLoaded else { return }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension DetailMealViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberSection = DetailMealViewModel.Section(rawValue: section) else {
            return 0
        }
        return viewModel.numberOfRowsInSection(section: numberSection)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = DetailMealViewModel.Section(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch section {
        case .image:
            let cell = tableView.dequeueReusableCell(withClass: ImageTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
            cell.selectionStyle = .none
            return cell
        case .information:
            let cell = tableView.dequeueReusableCell(withClass: InfoTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAtInformation(indexPath: indexPath)
            cell.selectionStyle = .none
            return cell
        case .video:
            let cell = tableView.dequeueReusableCell(withClass: VideoTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
            cell.selectionStyle = .none
            return cell
        case .instruction:
            let cell = tableView.dequeueReusableCell(withClass: InstructionsTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
            cell.selectionStyle = .none
            return cell
        case .ingrentMeasure:
            let cell = tableView.dequeueReusableCell(withClass: IngredientMeasureTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAtIngredientMeasure(indexPath: indexPath)
            cell.selectionStyle = .none
            return cell
        case .linkSource:
            let cell = tableView.dequeueReusableCell(withClass: SourceLinkTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
            cell.selectionStyle = .none
            return cell
        case .otherFood:
            let cell = tableView.dequeueReusableCell(withClass: OtherFoodTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowRandomMeal(indexPath: indexPath)
            cell.selectionStyle = .none
            return cell
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.headerTitler[section]
    }
}
