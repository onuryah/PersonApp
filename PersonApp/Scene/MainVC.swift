//
//  ViewController.swift
//  PersonApp
//
//  Created by Macbook on 7.04.2023.
//

import UIKit

class MainVC: BaseVC {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noOneLabel: UILabel!
    
    let refreshControl = UIRefreshControl()
    var viewModel: MainBussinessLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainVM()
        configrationTableView()
        setAlertDelegate()
        getFirstDatas()
    }
    
    private func getFirstDatas() {
        viewModel?.fetchData()
        viewModel?.reloadTableView {
            self.tableView.reloadData()
            self.hideViewsByDataCheck()
        }
    }
    
    private func setAlertDelegate() {
        viewModel?.delegate = self
    }
    
    @objc private func resetTableView(_ sender: AnyObject) {
        viewModel?.pagination = nil
        viewModel?.personArray.removeAll()
        self.tableView.reloadData()
        viewModel?.fetchData()
        viewModel?.reloadTableView {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            self.hideViewsByDataCheck()
        }
    }
    
    private func hideViewsByDataCheck() {
        self.noOneLabel.isHidden = self.viewModel?.personArray.count != .zero
    }
    
    private func configrationTableView() {
        tableView.addSubview(refreshControl)
        tableView.delegate = viewModel?.dataSource
        tableView.dataSource = viewModel?.dataSource
        refreshControl.addTarget(self, action: #selector(resetTableView(_:)), for: .valueChanged)
    }
}

