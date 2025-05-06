//
//  RegisterView.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 25/03/25.
//

import SwiftUI

struct RegisterView: View {
    @AppStorage("isRegistered") private var isRegistered = false
    @State private var username = ""
    @State private var email = ""

    var body: some View {
        VStack {
            Text("Log In")
                .font(.largeTitle)
                .bold()
                .padding()

            TextField("User name", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                if !username.isEmpty && !email.isEmpty {
                    isRegistered = true  // Guarda el estado del registro
                }
            }) {
                Text("Registrarse")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .padding()
    }
}

#Preview {
    RegisterView()
}
