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

    override func viewWillAppear(_ animated: Bool) {
        configNavi()
        updateView()
    }

    override func setUpUI() {
        configNavi()
    }

    override func setUpData() {
        loadAPIDetail()
        loadAPIRandomMeal()
        registerTableCell()
    }

    // MARK: - Private Functions
    private func configNavi() {
        viewModel.checkFavorites { (done, msg) in
            if done {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: DetailMealViewModel.Configure.iconAddFavorites), style: .plain, target: self, action: #selector(self.rightBarButtonTouchUpInside))
            } else {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: DetailMealViewModel.Configure.iconRemoveFavorites), style: .plain, target: self, action: #selector(self.rightBarButtonTouchUpInside))
            }
        }
    }

    @objc private func rightBarButtonTouchUpInside() {
        if viewModel.isFavorites == false {
            addToFavorites()
        } else {
            deteleToFavorties()
        }
    }

    func addToFavorites() {
        viewModel.addFavorites(addCompletion: { (done, msg) in
            if done {
                let image = UIImage(systemName: DetailMealViewModel.Configure.iconRemoveFavorites)
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.rightBarButtonTouchUpInside))
                print(msg)
            } else {
                self.showAlert(message: msg)
            }
        })
    }

    func deteleToFavorties() {
        viewModel.deleteFavorites(deleteCompletion: { (done, msg) in
            if done {
                let image = UIImage(systemName: DetailMealViewModel.Configure.iconAddFavorites)
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.rightBarButtonTouchUpInside))
            } else {
                self.showAlert(message: msg)
            }
        })
    }

    private func loadAPIDetail() {
        viewModel.getAPIDetailMeal { (done, msg) in
            if done {
                self.updateView()
            } else {
                self.showAlert(message: msg)
            }
        }
    }

    private func loadAPIRandomMeal() {
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
            let cell = tableView.dequeueReusableCell(withClass: IngredientMeasureTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
            return cell
        } else if indexPath.section == 5 {
            let cell = tableView.dequeueReusableCell(withClass: SourceLinkTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
            return cell
        } else if indexPath.section == 6 {
            let cell = tableView.dequeueReusableCell(withClass: OtherFoodTableViewCell.self, for: indexPath)
            cell.viewModel = viewModel.cellForRowRandomMeal(indexPath: indexPath)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 6 {
            let vc = DetailMealViewController()
            vc.viewModel = viewModel.pushIdMeal(indexPath: indexPath)
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.headerTitler[section]
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return DetailMealViewModel.Configure.spaceForSection
    }
}
