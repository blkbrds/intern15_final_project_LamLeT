//
//  SearchViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 6/18/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

// MARK: - Define
private struct Configure {
    static let title: String = "Search Meal"
    static let uiOffSet: UIOffset = UIOffset(horizontal: UIScreen.main.bounds.width / 2, vertical: UIScreen.main.bounds.height / 2)
    static let sizeForCellCollection: CGSize = CGSize(width: (UIScreen.main.bounds.width - CGFloat(25)) / 2, height: 150)
    static let spaceForCell: UIEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
}

final class SearchViewController: BaseViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!

    // MARK: - Properties
    var viewModel: SearchViewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Configure.title
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
            guard let this = self else { return }
            if done {
                this.updateUI()
            } else {
                this.showAlert(message: msg)
            }
        }
    }

    private func loadAPISearchByName(nameMeal: String?) {
        viewModel.searchAPIByName(nameMeal: nameMeal) { [weak self] (done, msg) in
            guard let this = self else { return }
            if done {
                this.updateUI()
            } else {
                this.showAlertSearch(message: msg)
                this.updateUI()
            }
        }
    }

    private func updateUI() {
        guard isViewLoaded else { return }
        tableView.reloadData()
        searchBar.becomeFirstResponder()
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

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailMealViewController()
        vc.viewModel = viewModel.pushToView(indexPath: indexPath)
        if let navigationController = navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - UISearchBarDelegate
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
    }
}
