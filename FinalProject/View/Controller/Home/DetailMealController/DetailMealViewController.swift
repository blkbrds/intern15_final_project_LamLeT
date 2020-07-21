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
        title = viewModel.nameMeal
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavi()
        updateView()
    }

    override func setUpUI() {
        tableView.isHidden = true
        configNavi()
        registerTableCell()
    }

    override func setUpData() {
        loadAPIDetail()
    }

    // MARK: - Private Functions
    private func configNavi() {
        navigationController?.navigationBar.tintColor = .black
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
        HUD.show()
        viewModel.getAPIDetailMeal { [weak self] (done, msg) in
            HUD.dismiss()
            guard let self = self else {
                return
            }
            if done {
                self.loadAPIRandomMeal()
                self.tableView.isHidden = false
            } else {
                self.showAlert(message: msg)
            }
        }
        HUD.setOffsetFromCenter(DetailMealViewModel.Configure.uiOffSet)
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
        tableView.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func updateView() {
        guard isViewLoaded else { return }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension DetailMealViewController: UITableViewDataSource, UITableViewDelegate {
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
