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
        setDelagates()
        addRefresh()
        viewModel?.fetchData()
        viewModel?.reloadTableView {
            self.tableView.reloadData()
            self.hideViewsByDataCheck()
        }
    }
    
    private func addRefresh() {
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
           tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    @objc func refresh(_ sender: AnyObject) {
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
        guard let people = viewModel?.personArray else { return }
        if people.isEmpty {
            noOneLabel.isHidden = false
        }else {
            noOneLabel.isHidden = true
        }
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    private func setDelagates() {
        tableView.delegate = self
        tableView.dataSource = self
        viewModel?.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.personArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonCell
        guard let person = viewModel?.personArray[indexPath.row]  else { return cell}
        cell.personLabel.text = (person.fullName ?? "") + " (\(person.id))"
        //        cell.setLabel()
        return cell
    }
}

extension MainVC {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let content = viewModel?.personArray {
            if indexPath.row == content.count - 1 {
                viewModel?.fetchData()
                viewModel?.reloadTableView {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

