//
//  Control.swift
//  Eventorias
//
//  Created by Bruno Evrard on 01/04/2025.
//

import Foundation
import UIKit

/// Controls the input of the different views of the application
public struct Control  {
    
    
    static func login(email: String, password: String) throws (ControlError) {
        try validateEmail(email)
        guard !password.isEmpty else {
            throw ControlError.passwordEmpty()
        }
    }
    
    static func signUp(email: String, password: String, confirmedPassword: String, name: String) throws (ControlError) {
        try validateEmail(email)
        guard !password.isEmpty else {
            throw ControlError.passwordEmpty()
        }
        if (!isValidPassword(password: password)) {
            throw ControlError.invalidPassword()
        }
        
        guard password == confirmedPassword else {
            throw ControlError.passwordNotMatch()
        }
        guard !name.isEmpty else {
            throw ControlError.nameEmpty()
        }
    }
    
    static func addEvent(event: EventViewData, eventTime: String, image: UIImage?, address: AddressResult?) throws (ControlError) {
        
        guard !event.title.isEmpty else {
            throw ControlError.emptyField(message: AppMessages.titleEmpty)
        }
        
        if (event.category == .unknown) {
            throw ControlError.emptyField(message: AppMessages.categoryEmpty)
        }
        guard !event.description.isEmpty else {
            throw ControlError.emptyField(message: AppMessages.descriptionEmpty)
        }
        
        if (event.dateEvent < Date()) {
            throw ControlError.errorDate(message: AppMessages.dateNotInFuture)
        }
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        guard let _ = timeFormatter.date(from: eventTime) else {
            throw ControlError.errorDate(message: AppMessages.hourError)
        }

        if (event.address.isEmpty) {
            throw ControlError.emptyField(message: AppMessages.adressEmpty)
        }
        
        if (address == nil) {
            throw ControlError.emptyField(message: AppMessages.adressEmpty)
        }
        
        if (image == nil) {
            throw ControlError.emptyField(message: AppMessages.pictureEmpty)
        }
    }
        
    private static func validateEmail(_ email: String) throws (ControlError) {
        guard !email.isEmpty else {
            throw ControlError.mailEmpty()
        }
        
        let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        
        guard emailPredicate.evaluate(with: email) else {
            throw ControlError.invalidFormatMail()
        }
    }
    
    private static func isValidPassword(password: String) -> Bool {
        // least one uppercase,
        // least one digit
        // least one lowercase
        // least one symbol
        //  min 8 characters total
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password)

    }
}
