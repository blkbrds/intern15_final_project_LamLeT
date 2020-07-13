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
        // Do any additional setup after loading the view.

    }

    override func setUpUI() {
        registerTable()
    }

    override func setUpData() {
        configSearchBar()
    }

    // MARK: - Private Functions
    private func configSearchBar() {
        searchBar.delegate = self
    }

    private func registerTable() {
        tableView.register(nibWithCellClass: SearchTableViewCell.self)
        tableView.dataSource = self
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
        HUD.show()
        viewModel.searchAPIByName(nameMeal: nameMeal) { [weak self] (done, msg) in
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

    private func updateUI() {
        guard isViewLoaded else { return }
        tableView.reloadData()
    }
}

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

extension SearchViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText != "" {
//            viewModel.mealResult = []
//            loadAPISearchByName(nameMeal: searchText)
//        }
//    }
//    }

    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var currentText = ""
        if let searchBarText = searchBar.text {
            currentText = searchBarText
        }
        let keyword = (currentText as NSString).replacingCharacters(in: range, with: text)
        viewModel.mealResult = []
        let additionalTime: DispatchTimeInterval = .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: .now() + additionalTime) {
            self.loadAPISearchByName(nameMeal: keyword)
            self.view.endEditing(true)
        }
        return true
    }

//    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
//        let searchText = searchBar.text
//        if searchText != "" {
//            viewModel.mealResult = []
//            loadAPISearchByName(nameMeal: searchText)
//        }
//        return true
//    }

//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        loadAPISearchByName(nameMeal: searchBar.text)
////        gameTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
//        view.endEditing(true)
//    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }

//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        self.loadAPISearchByName(nameMeal: searchBar.text)
//        let additionalTime: DispatchTimeInterval = .seconds(2)
//        DispatchQueue.main.asyncAfter(deadline: .now() + additionalTime) {
//            self.loadAPISearchByName(nameMeal: searchBar.text)
//        }
//    }
//
//    func runTimedCode() {
//        loadAPISearchByName(nameMeal: searchBar.text)
//        view.endEditing(true)
//    }
}
