//
//  ViewController.swift
//  PersonApp
//
//  Created by Macbook on 7.04.2023.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noOneLabel: UILabel!
    
    var viewModel: MainBussinessLayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainVM()
        setDelagates()
        viewModel?.fetchData()
        viewModel?.reloadTableView(completion: {
            self.tableView.reloadData()
        })
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    private func setDelagates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.personArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonCell
        let person = viewModel?.personArray[indexPath.row]
        cell.personLabel.text = (person?.fullName ?? "") + "\(person?.id)"
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

