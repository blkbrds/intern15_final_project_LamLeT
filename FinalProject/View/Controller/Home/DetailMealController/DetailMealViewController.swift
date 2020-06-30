//
//  DetailMealViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 6/25/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

class DetailMealViewController: BaseViewController {

    // MARK: - IBOulet
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    var viewModel: DetailMealViewModel = DetailMealViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func setUpUI() {
        configNavi()
    }

    override func setUpData() {
        loadAPI()
        registerTableCell()
    }

    // MARK: - Private Functions
    private func configNavi() {

    }
    
    private func loadAPI() {
        viewModel.getAPIDetailMeal { (done, msg) in
            if done {
                self.updateView()
            } else {
                print("Failed")
            }
        }
    }

    private func registerTableCell() {
        tableView.register(nibWithCellClass: ImageTableViewCell.self)
        tableView.register(nibWithCellClass: InfoTableViewCell.self)
        tableView.register(nibWithCellClass: VideoTableViewCell.self)
        tableView.register(nibWithCellClass: InstructionsTableViewCell.self)
        tableView.register(nibWithCellClass: IngredientTableViewCell.self)
        tableView.register(nibWithCellClass: MeasureTableViewCell.self)
        tableView.register(nibWithCellClass: SourceLinkTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func updateView() {
        tableView.reloadData()
    }
    
}

extension DetailMealViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withClass: ImageTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withClass: InfoTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withClass: VideoTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withClass: InstructionsTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
            return cell
        } else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withClass: IngredientTableViewCell.self, for: indexPath)
            return cell
        } else if indexPath.section == 5 {
            let cell = tableView.dequeueReusableCell(withClass: MeasureTableViewCell.self, for: indexPath)
            return cell
        } else if indexPath.section == 6 {
            let cell = tableView.dequeueReusableCell(withClass: MeasureTableViewCell.self, for: indexPath)
            return cell
        }
        return UITableViewCell()
    }
}
