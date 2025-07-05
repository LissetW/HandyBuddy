//
//  SignUpView.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 02/07/25.
//

import SwiftUI
import PhotosUI
import FirebaseAuth

struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker = false

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            ScrollView {
                VStack(spacing: 16) {
                    Text(NSLocalizedString("signup.title", comment: ""))
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 24)

                    // Profile Image
                    Group {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                        }
                    }
                    .background(Circle().fill(Color.gray.opacity(0.2)))

                    Button(NSLocalizedString("signup.uploadPhoto", comment: "")) {
                        showImagePicker = true
                    }
                    .font(.subheadline)
                    .padding(.bottom, 16)

                    // Fields
                    Group {
                        VStack(alignment: .leading, spacing: 4) {
                            TextField(NSLocalizedString("signup.fullName.placeholder", comment: ""), text: $viewModel.fullName)
                                .textFieldStyle(.roundedBorder)
                            if let error = viewModel.fullNameError {
                                Text(error)
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            TextField(NSLocalizedString("signup.email.placeholder", comment: ""), text: $viewModel.email)
                                .keyboardType(.emailAddress)
                                .textFieldStyle(.roundedBorder)
                            if let error = viewModel.emailError {
                                Text(error)
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            SecureField(NSLocalizedString("signup.password.placeholder", comment: ""), text: $viewModel.password)
                                .textFieldStyle(.roundedBorder)
                            if let error = viewModel.passwordError {
                                Text(error)
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            SecureField(NSLocalizedString("signup.repeatPassword.placeholder", comment: ""), text: $viewModel.confirmPassword)
                                .textFieldStyle(.roundedBorder)
                            if let error = viewModel.confirmPasswordError {
                                Text(error)
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }
                        }
                    }
                    .padding(.horizontal)

                    // General error
                    if let generalError = viewModel.generalError {
                        Text(generalError)
                            .foregroundColor(.red)
                            .font(.subheadline)
                            .padding(.horizontal)
                            .multilineTextAlignment(.center)
                    }

                    // Sign up button
                    Button(action: {
                        viewModel.signUp()
                    }) {
                        Text(NSLocalizedString("signup.button.signUp", comment: ""))
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
                .padding(.bottom, 40)
            }

            if viewModel.isLoading {
                Color.black.opacity(0.3).ignoresSafeArea()
                ProgressView().scaleEffect(2)
            }
        }
        .sheet(isPresented: $showImagePicker) {
            // ImagePicker(image: $selectedImage)
        }
    }
}
