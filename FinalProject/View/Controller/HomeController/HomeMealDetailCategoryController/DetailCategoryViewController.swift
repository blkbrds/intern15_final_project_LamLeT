//
//  DetailCategoryViewController.swift
//  FinalProject
//
//  Created by PCI0002 on 6/22/20.
//  Copyright © 2020 Thinh Nguyen X. All rights reserved.
//

import UIKit
import SVProgressHUD

final class DetailCategoryViewController: BaseViewController {

    // MARK: - Properties
    @IBOutlet private weak var tableView: UITableView!
    var viewModel: DetailCategoryViewModel?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setUpUI() {
        configNavi()
    }

    override func setUpData() {
        registerTableCell()
        loadAPI()
    }

    // MARK: - Private Functions
    private func configNavi() {
        title = viewModel?.nameCategory
    }

    private func registerTableCell() {
        let nib = UINib(nibName: "DetailCategoryTableViewCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func loadAPI() {
        guard let viewModel = viewModel else {
            return
        }
        SVProgressHUD.show()
        viewModel.getAPIListCategory(detailCategoryCompletion: { (done, msg) in
            SVProgressHUD.dismiss()
            if done {
                self.updateUI()
            } else {
                self.showAlert(message: msg)
            }
        })
        SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: UIScreen.main.bounds.width / 2, vertical: UIScreen.main.bounds.height / 2))
    }

    private func updateUI() {
        tableView.reloadData()
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Connect API", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Connect", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension DetailCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailCategoryTableViewCell
        cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.heightForRowAt()
    }
}
