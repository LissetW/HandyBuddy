//
//  LoginViewModel.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 02/07/25.
//

import Foundation
import FirebaseAuth
import SwiftUI

class LoginViewModel: ObservableObject {
    @AppStorage("isLoggedIn") var isLoggedIn = false

    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false

    @Published var emailError: String?
    @Published var passwordError: String?
    @Published var generalError: String?
    @Published var showEmailNotVerified = false

    func login() {
        // Limpiar errores anteriores
        emailError = nil
        passwordError = nil
        generalError = nil
        showEmailNotVerified = false
        var hasError = false

        // Validar campos
        let emailValidation = AuthValidator.validateEmail(email)
        if !emailValidation.isValid {
            emailError = emailValidation.errorMessage
            hasError = true
        }

        let passwordValidation = AuthValidator.basicValidatePassword(password)
        if !passwordValidation.isValid {
            passwordError = passwordValidation.errorMessage
            hasError = true
        }

        if hasError {
            return
        }

        isLoading = true

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                self?.isLoading = false

                if let error = error as NSError? {
                    switch AuthErrorCode(rawValue: error.code) {
                    case .invalidEmail:
                        self?.emailError = "The email address has an invalid format."
                    case .wrongPassword:
                        self?.passwordError = "Incorrect password. Please try again."
                    case .userNotFound:
                        self?.generalError = "No user found with this email."
                    case .userDisabled:
                        self?.generalError = "This account has been disabled."
                    case .tooManyRequests:
                        self?.generalError = "Too many attempts. Please try again later."
                    default:
                        self?.generalError = "Authentication failed. Please check your email and password."
                    }
                    return
                }

                guard let user = result?.user else {
                    self?.generalError = "User not found."
                    return
                }

                if !user.isEmailVerified {
                    self?.showEmailNotVerified = true
                } else {
                    self?.isLoggedIn = true
                }
            }
        }
    }

    func resendVerificationEmail() {
        guard let user = Auth.auth().currentUser else {
            generalError = "No user is logged in."
            return
        }

        user.sendEmailVerification { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.generalError = error.localizedDescription
                } else {
                    self?.generalError = "Verification email sent."
                }
            }
        }
    }
}
