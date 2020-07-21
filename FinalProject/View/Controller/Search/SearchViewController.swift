//
//  SearchViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 6/18/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

final class SearchViewController: BaseViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!

    // MARK: - Properties
    var viewModel: SearchViewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = SearchViewModel.Configure.title
        // Do any additional setup after loading the view.

    }

    override func setUpUI() {
        registerTable()
    }

    override func setUpData() {
        configSearchBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Private Functions
    private func configSearchBar() {
        searchBar.delegate = self
    }

    private func registerTable() {
        tableView.register(nibWithCellClass: SearchTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }

    private func loadAPISearchFirstLetter(firstLetter: String) {
        HUD.show()
        viewModel.searchAPIFirstLetter(firstLetter: firstLetter) { [weak self] (done, msg) in
            HUD.dismiss()
            guard let self = self else { return }
            if done {
                self.updateUI()
            } else {
                self.showAlert(message: msg)
            }
        }
        HUD.setOffsetFromCenter(SearchViewModel.Configure.uiOffSet)
    }

    private func loadAPISearchByName(nameMeal: String?) {
        viewModel.searchAPIByName(nameMeal: nameMeal) { [weak self] (done, msg) in
            guard let self = self else { return }
            if done {
                self.updateUI()
            } else {
                self.showAlert(message: msg)
            }
        }
    }

    private func updateUI() {
        guard isViewLoaded else { return }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSourrce
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: SearchTableViewCell.self, for: indexPath)
        cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailMealViewController()
        vc.viewModel = viewModel.pushToView(indexPath: indexPath)
        if let navigationController = navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var currentText = ""
        if let searchBarText = searchBar.text {
            currentText = searchBarText
        }
        let keyword = (currentText as NSString).replacingCharacters(in: range, with: text)
        viewModel.mealResult = []
        let additionalTime: DispatchTimeInterval = .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: .now() + additionalTime) {
            self.loadAPISearchByName(nameMeal: keyword)
            self.view.endEditing(true)
        }
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.loadAPISearchByName(nameMeal: searchBar.text)
    }
}
