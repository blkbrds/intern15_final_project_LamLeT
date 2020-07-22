//
//  FavoritesViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 6/18/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit

final class FavoritesViewController: BaseViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    var viewModel = FavoritesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.setupObserve()
    }

    override func setUpUI() {
        configNavi()
        registerTable()
    }

    private func configNavi() {
        title = viewModel.title
        let imageDelete = UIImage(systemName: App.String.nameIconDelete)
        let backButton = UIBarButtonItem(image: imageDelete, style: .plain, target: self, action: #selector(deleteButtonTouchUpInside))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

    private func registerTable() {
        tableView.register(nibWithCellClass: FavoritesTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

    private func fetchData() {
        viewModel.fetchData { [weak self] (done, error) in
            guard let this = self else { return }
            if done {
                this.updateUI()
            } else {
                this.showAlert(message: error)
            }
        }
    }

    @objc func deleteButtonTouchUpInside() {
        viewModel.deleteAll { [weak self] (done) in
            guard let this = self else { return }
            if done {
                this.fetchData()
            } else {
                this.showAlert(message: App.String.deleteObjectFailed)
            }
        }
    }

    private func updateUI() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: FavoritesTableViewCell.self, for: indexPath)
        cell.viewModel = viewModel.favoritesCell(at: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            self.viewModel.deleteOneObject(indexPath: indexPath) { (done, msg) in
                if done {
                    viewModel.meals.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                } else {
                    self.showAlert(message: App.String.deleteObjectFailed)
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailMealViewController()
        vc.viewModel = viewModel.pushToView(indexPath: indexPath)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - FavoritesViewModelDelegate
extension FavoritesViewController: FavoritesViewModelDelegate {
    func viewModel(_ viewModel: FavoritesViewModel, needperfomAction action: FavoritesViewModel.Action) {
        fetchData()
    }
}
