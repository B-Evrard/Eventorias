//
//  FBAuthService.swift
//  Eventorias
//
//  Created by Bruno Evrard on 28/03/2025.
//

import Foundation
import FirebaseAuth

public class FBAuthService {
    
    func signInWithEmailLink(email: String) async -> Result<Bool, Error> {
        
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "https://eventorias-47db6.firebaseapp.com")
        
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        
        do {
             try await Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings)
            return .success(true)
           }
       catch {
         print(error.localizedDescription)
           return .failure(error)
       }
        
        
    }
}
