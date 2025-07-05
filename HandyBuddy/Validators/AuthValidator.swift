//
//  AuthValidator.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 02/07/25.
//

import Foundation

struct ValidationResult {
    let isValid: Bool
    let errorMessage: String?
}

struct AuthValidator {
    static func validateEmail(_ email: String) -> ValidationResult {
            if email.trimmingCharacters(in: .whitespaces).isEmpty {
                return ValidationResult(isValid: false, errorMessage: "Email is required.")
            }
            
            let emailRegEx = #"^\S+@\S+\.\S+$"#
        if (email.range(of: emailRegEx, options: .regularExpression, range: nil, locale: nil) == nil){
                return ValidationResult(isValid: false, errorMessage: "Email format is invalid.")
            }
            return ValidationResult(isValid: true, errorMessage: nil)
        }
        
        static func basicValidatePassword(_ password: String) -> ValidationResult {
            if password.isEmpty {
                return ValidationResult(isValid: false, errorMessage: "Password is required.")
            }
            return ValidationResult(isValid: true, errorMessage: nil)
        }
        
        static func validatePassword(_ password: String) -> ValidationResult {
            if password.isEmpty {
                return ValidationResult(isValid: false, errorMessage: "Password is required.")
            }
            if password.count < 6 {
                return ValidationResult(isValid: false, errorMessage: "Password must be at least 6 characters.")
            }
            if password.rangeOfCharacter(from: .uppercaseLetters) == nil {
                return ValidationResult(isValid: false, errorMessage: "Password must contain at least one uppercase letter.")
            }
            if password.rangeOfCharacter(from: .lowercaseLetters) == nil {
                return ValidationResult(isValid: false, errorMessage: "Password must contain at least one lowercase letter.")
            }
            if password.rangeOfCharacter(from: .decimalDigits) == nil {
                return ValidationResult(isValid: false, errorMessage: "Password must contain at least one digit.")
            }
            let specialCharacterSet = CharacterSet.letters.union(.decimalDigits).inverted
            if password.rangeOfCharacter(from: specialCharacterSet) == nil {
                return ValidationResult(isValid: false, errorMessage: "Password must contain at least one special character.")
            }
            return ValidationResult(isValid: true, errorMessage: nil)
        }
        
        static func confirmPasswordsMatch(password: String, confirmPassword: String) -> ValidationResult {
            if password.isEmpty || confirmPassword.isEmpty {
                return ValidationResult(isValid: false, errorMessage: "Password and confirmation are required.")
            }
            if password != confirmPassword {
                return ValidationResult(isValid: false, errorMessage: "Passwords do not match.")
            }
            return ValidationResult(isValid: true, errorMessage: nil)
        }
}
