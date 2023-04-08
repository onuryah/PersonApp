//
//  ViewController.swift
//  PersonApp
//
//  Created by Macbook on 7.04.2023.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: MainBussinessLayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainVM()
        setDelagates()
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    private func setDelagates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonCell
        cell.setLabel()
        return cell
    }
}

