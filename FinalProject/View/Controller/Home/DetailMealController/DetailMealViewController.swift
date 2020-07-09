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
        loadAPI()
    }

    // MARK: - Private Functions
    private func configNavi() {

    }

    private func loadAPI() {
        HUD.show()
        viewModel.getAPIDetailMeal { [weak self] (done, msg) in
            guard let self = self else {
                return
            }
            HUD.dismiss()   
            if done {
                self.updateView()
            } else {
                self.showAlert(message: msg)
            }
        }
        HUD.setOffsetFromCenter(DetailMealViewModel.Configure.uiOffSet)
    }

    private func registerTableCell() {
        tableView.register(nibWithCellClass: ImageTableViewCell.self)
        tableView.register(nibWithCellClass: InfoTableViewCell.self)
        tableView.register(nibWithCellClass: VideoTableViewCell.self)
        tableView.register(nibWithCellClass: InstructionsTableViewCell.self)
        tableView.register(nibWithCellClass: IngredientTableViewCell.self)
        tableView.register(nibWithCellClass: MeasureTableViewCell.self)
        tableView.register(nibWithCellClass: SourceLinkTableViewCell.self)
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
            return cell
        case .information:
            let cell = tableView.dequeueReusableCell(withClass: InfoTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
            return cell
        case .video:
            let cell = tableView.dequeueReusableCell(withClass: VideoTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
            return cell
        case .instruction:
            let cell = tableView.dequeueReusableCell(withClass: InstructionsTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
            return cell
        case .ingrentMeasure:
            let cell = tableView.dequeueReusableCell(withClass: IngredientTableViewCell.self, for: indexPath)
            return cell
        case .linkSource:
            let cell = tableView.dequeueReusableCell(withClass: MeasureTableViewCell.self, for: indexPath)
            return cell
        case .otherFood:
            let cell = tableView.dequeueReusableCell(withClass: MeasureTableViewCell.self, for: indexPath)
            return cell
        }
    }
}
