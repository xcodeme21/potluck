//
//  LoginViewModel.swift
//  Potluck Erajaya
//
//  Created by Agus Siswanto on 15/12/23.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isEmailValid: Bool = true
    @Published var isPasswordValid: Bool = true
    @Published var isPasswordHidden: Bool = true
    @Published var showAlert: Bool = false
    @Published var loginResponse: LoginResponse?
    @Published var shouldNavigateToHome = false
    
    private var loginService: LoginService
    
    init(loginService: LoginService = LoginService()) {
        self.loginService = loginService
    }
    
    var isValidCredentials: Bool {
        return isValidEmail(email) && isValidPassword(password)
    }

    func isValidEmail(_ email: String) -> Bool {
        return email.contains("@erajaya.com")
    }

    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }
    
    func login() {
        guard isValidEmail(email) else {
            isEmailValid = false
            return
        }
        
        guard isValidPassword(password) else {
            isPasswordValid = false
            return
        }
        
        loginService.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                print(result, "tes")
                switch result {
                case .success(let response):
                    self.loginResponse = response
                    self.saveOutputToUserDefaults(response)
                case .failure:
                    self.showAlert = true
                }
            }
        }
    }
    
    func togglePasswordVisibility() {
        isPasswordHidden.toggle()
    }
    
    func saveOutputToUserDefaults(_ response: LoginResponse) {
        if let outputData = try? JSONEncoder().encode(response.output) {
            UserDefaults.standard.set(outputData, forKey: "loggedInUserOutput")
            self.redirectToHome()
        }
    }
    
    func redirectToHome() {
        self.shouldNavigateToHome = true
    }
}

