//
//  MainTableViewDataSource.swift
//  PersonApp
//
//  Created by Macbook on 10.04.2023.
//

import UIKit

final class MainDataSource: NSObject {
    var personArray: [Person] = []
    var loadMore: (() -> Void)? = nil
}

extension MainDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonCell
        let model = personArray[indexPath.row]
        cell.setLabel(person: model)
        
        return cell
    }
}

extension MainDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == personArray.count - 1 {
            loadMore?()
        }
    }
}
