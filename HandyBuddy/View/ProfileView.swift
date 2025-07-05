//
//  ProfileView.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 24/03/25.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @StateObject private var sessionManager = SessionManager()
    
    private var displayName: String {
        Auth.auth().currentUser?.displayName ?? "Guest"
    }

    var body: some View {
        NavigationView {
            List {
                // Usuario
                Section {
                    HStack(spacing: 16) {
                        Image("2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(displayName)
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                // Legal
                Section(header: Text("profile.section.legal")) {
                    NavigationLink("profile.termsOfService", destination: TermsOfServiceView())
                    NavigationLink("profile.privacyPolicy", destination: PrivacyPolicyView())
                }

                // Cerrar sesión
                Section {
                    Button(role: .destructive) {
                        sessionManager.logout()
                    } label: {
                        Text("profile.button.logOut")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .navigationTitle("profile.title")
        }
    }
}
