//
//  SignUpViewModel.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 03/07/25.
//


import Foundation
import FirebaseAuth

class SignUpViewModel: ObservableObject {
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""

    @Published var fullNameError: String?
    @Published var emailError: String?
    @Published var passwordError: String?
    @Published var confirmPasswordError: String?
    @Published var generalError: String?

    @Published var isLoading = false
    @Published var isSignedUp = false

    func signUp() {
        // Limpiar errores previos
        fullNameError = nil
        emailError = nil
        passwordError = nil
        confirmPasswordError = nil
        generalError = nil

        var hasError = false

        // Validar nombre
        if fullName.trimmingCharacters(in: .whitespaces).isEmpty {
            fullNameError = "Full name is required."
            hasError = true
        }

        // Validar email
        let emailValidation = AuthValidator.validateEmail(email)
        if !emailValidation.isValid {
            emailError = emailValidation.errorMessage
            hasError = true
        }

        // Validar password
        let passwordValidation = AuthValidator.validatePassword(password)
        if !passwordValidation.isValid {
            passwordError = passwordValidation.errorMessage
            hasError = true
        }

        // Validar confirmación
        let matchValidation = AuthValidator.confirmPasswordsMatch(password: password, confirmPassword: confirmPassword)
        if !matchValidation.isValid {
            confirmPasswordError = matchValidation.errorMessage
            hasError = true
        }

        if hasError {
            return
        }

        isLoading = true

        // Crear usuario en Firebase
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                self?.isLoading = false

                if let error = error as NSError? {
                    switch AuthErrorCode(rawValue: error.code) {
                    case .emailAlreadyInUse:
                        self?.emailError = "Email is already in use."
                    case .invalidEmail:
                        self?.emailError = "Invalid email address."
                    case .weakPassword:
                        self?.passwordError = "Password is too weak."
                    default:
                        self?.generalError = "Sign up failed. Please try again."
                    }
                    return
                }

                self?.isSignedUp = true

                // Enviar correo de verificación
                result?.user.sendEmailVerification(completion: nil)
            }
        }
    }
}
