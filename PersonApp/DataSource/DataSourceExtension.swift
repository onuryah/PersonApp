//
//  DataSourceExtension.swift
//  PersonApp
//
//  Created by Macbook on 8.04.2023.
//

import Foundation
fileprivate extension DataSource {
    func handleError(response: URLResponse?, with data: Data?) -> NetworkError? {
        if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
            if response.statusCode == 401 {
               return NetworkError.serverError(code: 401, error: "Session Hata", stringCode: nil)
                
            }else if response.statusCode == 500 {
                return NetworkError.serverError(code: 500, error: "Teknik bir hata (500)", stringCode: nil)
            }else {
                if let data = data,
                    let mesaj = try? JSONDecoder().decode(ErrorResponseParentModel.self, from: data) {
                    return NetworkError.serverError(code: 0, error: mesaj.error.message, stringCode: mesaj.error.errorCode ?? "")
                }
            }
        }
        return nil
    }
}
