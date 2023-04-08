//
//  BaseVC.swift
//  PersonApp
//
//  Created by Macbook on 8.04.2023.
//

import UIKit

class BaseVC: UIViewController {

}

extension BaseVC: BaseDelegateProtocol {
    func createFailureAlert(failMessage: String) {
        let alert = UIAlertController(title: "Alert", message: failMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
