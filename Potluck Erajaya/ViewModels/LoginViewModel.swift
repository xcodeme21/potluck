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
                switch result {
                case .success(let response):
                    self.loginResponse = response
                    print(response)
                    if response.success == true {
                        if let outputData = response.output {
                            let userData = UserData(email: outputData.email,
                                                    group: outputData.group,
                                                    mailServer: outputData.mailServer,
                                                    name: outputData.name,
                                                    title: outputData.title,
                                                    username: outputData.username,
                                                    yourIP: outputData.yourIP)
                            self.saveOutputToUserDefaults(userData)
                        }
                    } else {
                        self.showAlert = true
                    }
                case .failure:
                    self.showAlert = true
                }
            }
        }
    }

    func saveOutputToUserDefaults(_ response: UserData) {
        if let outputData = try? JSONEncoder().encode(response) {
            UserDefaults.standard.set(outputData, forKey: "userData")
            self.redirectToHome()
        }
    }
    
    func togglePasswordVisibility() {
        isPasswordHidden.toggle()
    }
    
    func redirectToHome() {
        self.shouldNavigateToHome = true
        print(self.shouldNavigateToHome) 
    }
}

