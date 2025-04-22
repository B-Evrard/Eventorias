//
//  ControlError.swift
//  Eventorias
//
//  Created by Bruno Evrard on 01/04/2025.
//

import Foundation

enum ControlError: Error {
    case mailEmpty(message: String = "Please enter an email address.")
    case invalidFormatMail(message: String = "Please enter a valid email address.")
    case passwordEmpty(message: String = "Please enter your password.")
    case passwordNotMatch(message: String = "Passwords do not match.")
    case invalidPassword(message: String = "Password invalid.")
    case nameEmpty(message: String = "Please enter your name.")
    case genericError(message: String = "An error has occurred.")
    case emptyField(message: String = "Please fill all fields.")
    case errorDate(message: String = "Date invalid")

    
    var message: String {
        switch self {
        case .mailEmpty(let message),
                .invalidFormatMail(let message),
                .passwordEmpty(let message),
                .genericError(let message),
                .nameEmpty(let message),
                .passwordNotMatch(let message),
                .invalidPassword(message: let message),
                .emptyField(message: let message),
                .errorDate(message: let message):
            return message
        
        }
    }
    
}


