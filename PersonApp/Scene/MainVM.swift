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
}

class MainVM: MainBussinessLayer {
    var personArray: [Person] = []
    var pagination: String?
    func fetchData() {
        DataSource.fetch(next: "0") {[weak self] response, error in
            guard let self = self else { return }
            if let error {
                
            } else {
                self.pagination = response?.next
                response?.people.forEach({ person in
                    self.personArray.append(person)
                    print("data eklendi")
                })
                print("işlem bitti")
            }
        }
    }
}
