//
//  LoginView.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 02/07/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var showPassword = false
    @State private var goToMain = false
    @State private var goToSignUp = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color("colorBackground")
                    .ignoresSafeArea()

                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                } else {
                    ScrollView {
                        VStack(spacing: 24) {
                            Spacer().frame(height: 170)

                            Text("login.title")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(Color("colorPrimaryVariant"))
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)

                            // Email
                            VStack(alignment: .leading, spacing: 8) {
                                Text("login.email.label")
                                    .foregroundColor(Color("colorOnSecondary"))

                                TextField("login.email.placeholder", text: $viewModel.email)
                                    .keyboardType(.emailAddress)
                                    .textContentType(.emailAddress)
                                    .autocapitalization(.none)
                                    .padding()
                                    .background(Color("colorOnPrimary"))
                                    .cornerRadius(8)

                                if let emailError = viewModel.emailError {
                                    Text(emailError)
                                        .foregroundColor(.red)
                                        .font(.caption)
                                }
                            }

                            // Password
                            VStack(alignment: .leading, spacing: 8) {
                                Text("login.password.label")
                                    .foregroundColor(Color("colorOnSecondary"))

                                HStack {
                                    Group {
                                        if showPassword {
                                            TextField("login.password.placeholder", text: $viewModel.password)
                                        } else {
                                            SecureField("login.password.placeholder", text: $viewModel.password)
                                        }
                                    }
                                    .textContentType(.password)

                                    Button {
                                        showPassword.toggle()
                                    } label: {
                                        Image(systemName: showPassword ? "eye.slash" : "eye")
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding()
                                .background(Color("colorOnPrimary"))
                                .cornerRadius(8)

                                if let passwordError = viewModel.passwordError {
                                    Text(passwordError)
                                        .foregroundColor(.red)
                                        .font(.caption)
                                }
                            }

                            // Forgot Password
                            HStack {
                                Spacer()
                                Button("login.forgotPassword") {
                                    // Acción para recuperar contraseña
                                }
                                .font(.system(size: 14))
                                .foregroundColor(Color("colorOnSecondary"))
                            }

                            // Login
                            Button {
                                viewModel.login()
                            } label: {
                                Text("login.button.login")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color("colorPrimary"))
                                    .cornerRadius(8)
                            }

                            // General error message
                            if let generalError = viewModel.generalError {
                                Text(generalError)
                                    .foregroundColor(.red)
                                    .font(.system(size: 14))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                            }

                            // Warning email not verified
                            if viewModel.showEmailNotVerified {
                                Text("login.error.emailNotVerified")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color("#856404"))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.yellow.opacity(0.2)))

                                Button("login.button.resendVerification") {
                                    viewModel.resendVerificationEmail()
                                }
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("colorSecondary"))
                                .cornerRadius(8)
                            }

                            // Sign up
                            Button("login.button.signUp") {
                                goToSignUp = true
                            }
                            .font(.system(size: 14))
                            .foregroundColor(Color("colorTextInput"))
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.horizontal, 32)
                        .padding(.bottom, 48)
                        .onChange(of: viewModel.email) {
                            viewModel.emailError = nil
                            viewModel.generalError = nil
                        }
                        .onChange(of: viewModel.password) {
                            viewModel.passwordError = nil
                            viewModel.generalError = nil
                        }
                    }
                }
            }
            .onChange(of: viewModel.isLoggedIn) {
                if viewModel.isLoggedIn {
                    goToMain = true
                }
            }
            .navigationDestination(isPresented: $goToMain) {
                MainView()
            }
            .navigationDestination(isPresented: $goToSignUp) {
                SignUpView()
            }
        }
    }
}
