//
//  MainVM.swift
//  PersonApp
//
//  Created by Macbook on 8.04.2023.
//

import Foundation

protocol MainBussinessLayer {
    var personArray: [Person] { get set }
    var pagination: String? { get set }
    func fetchData()
    func reloadTableView(completion: @escaping () -> Void)
}

class MainVM: MainBussinessLayer {
    var personArray: [Person] = []
    let group = DispatchGroup()
    var pagination: String? = "0"
    func fetchData() {
        group.enter()
        DataSource.fetch(next: pagination) {[weak self] response, error in
            guard let self = self else { return }
            if error != nil {
                print(error?.errorDescription)
            } else {
                if let next = response?.next {
                    self.pagination = next
                    print(self.pagination)
                }
                response?.people.forEach({ person in
                    self.personArray.append(person)
                })
                self.group.leave()
            }
        }
    }
    
    func reloadTableView(completion: @escaping () -> Void) {
        group.notify(queue: .main) {
            completion()
        }
    }
}
