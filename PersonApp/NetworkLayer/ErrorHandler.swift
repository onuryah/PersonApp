//
//  DataSourceExtension.swift
//  PersonApp
//
//  Created by Macbook on 8.04.2023.
//


public class FetchError {
    init(errorType: ErrorType) {
        self.errorType = errorType
    }
    
    enum ErrorType: Error {
        case serverError
        case parameterError
    }
    
    let errorType: ErrorType
    
    
    var errorDescription: String {
        switch errorType {
        case .serverError:
            return "Internal Server Error"
        case .parameterError:
            return "Parameter error"
        }
    }
}

