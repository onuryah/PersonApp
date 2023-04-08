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
    var delegate: BaseDelegateProtocol? { get set }
    func fetchData()
    func reloadTableView(completion: @escaping () -> Void)
}

class MainVM: MainBussinessLayer {
    var personArray: [Person] = []
    let group = DispatchGroup()
    var delegate: BaseDelegateProtocol?
    var pagination: String? = nil
    func fetchData() {
        self.delegate?.createFailureAlert(failMessage: "errorMessage")
        group.enter()
        DataSource.fetch(next: pagination) {[weak self] response, error in
            guard let self = self else { return }
            if error != nil {
                if let errorMessage = error?.errorDescription {
                    self.delegate?.createFailureAlert(failMessage: errorMessage)
                }
            } else {
                if let next = response?.next {
                    self.pagination = next
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
