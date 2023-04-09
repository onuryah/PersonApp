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
    var pagination: String? = "0"
    var delay = 3.0
    var delayIncreaser = 3.0
    
    func fetchData() {
        group.enter()
        DataSource.fetch(next: pagination) {[weak self] response, error in
            guard let self = self else { return }
            if error != nil {
                if let errorMessage = error?.errorDescription {
                    self.delegate?.createFailureAlert(failMessage: errorMessage)
                    self.retry()
                }
            } else {
                if let next = response?.next {
                    self.pagination = next
                }
                response?.people.forEach({ person in
                    self.addUniquePerson(person: person)
                })
                self.delay = 3.0
            }
            self.group.leave()
        }
    }
    
    func retry() {
        group.enter()
        DispatchQueue.global().asyncAfter(deadline: .now() + delay) {[weak self] in
            guard let self = self else { return }
            print(self.delay)
            self.delay += self.delayIncreaser
            self.fetchData()
            self.group.leave()
        }
    }
    
    func reloadTableView(completion: @escaping () -> Void) {
        group.notify(queue: .main) {
            completion()
        }
    }
    
    func addUniquePerson(person: Person) {
        let existingPerson = personArray.filter { $0.id == person.id }.first
        if existingPerson == nil {
            personArray.append(person)
        }
    }
}
