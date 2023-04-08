//
//  MainVM.swift
//  PersonApp
//
//  Created by Macbook on 8.04.2023.
//

import Foundation

protocol MainBussinessLayer {
    func fetchData()
    var personArray: [Person] { get }
    func reloadTableView(completion: @escaping () -> Void)
}

class MainVM: MainBussinessLayer {
    var personArray: [Person] = []
//    let queue = DispatchQueue(label: "com.wait.queue", qos: .background, attributes: .concurrent)
    let group = DispatchGroup()
    var pagination: String?
    func fetchData() {
        group.enter()
        DataSource.fetch(next: "0") {[weak self] response, error in
            guard let self = self else { return }
            if let error {
                
            } else {
                self.pagination = response?.next
                response?.people.forEach({ person in
                    self.personArray.append(person)
                    print("data eklendi")
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
