//
//  ChatView.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 15/06/25.
//

import SwiftUI
import SwiftData

struct ChatView: View {
    @Environment(\.modelContext) private var modelContext

    @StateObject private var messageViewModel = MessageViewModel()
    @StateObject private var technicianViewModel = TechnicianViewModel()
    @StateObject private var previewsViewModel = MessagesPreviewViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                if previewsViewModel.chatPreviews.isEmpty {
                    Text(String(localized: "chatView.noMessages"))
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(previewsViewModel.chatPreviews) { chat in
                        NavigationLink(destination: ChatDetailView(session: chat.fullMessageSession, technician: chat)) {
                            ChatPreviewRow(chat: chat)
                        }
                    }
                    .opacity(messageViewModel.isLoading ? 0.5 : 1)
                }

                if messageViewModel.isLoading {
                    ProgressView(String(localized: "chatView.loading"))
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(radius: 4)
                }

                if let error = messageViewModel.errorMessage {
                    VStack {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                        Spacer()
                    }
                }
            }
            .navigationTitle(String(localized: "chatView.title"))
            .onAppear {
                messageViewModel.setContextIfNeeded(modelContext)
                previewsViewModel.setContextIfNeeded(modelContext)

                Task {
                    await technicianViewModel.fetchTechnicians()
                    await messageViewModel.fetchSessions()

                    print("[Debug] messageViewModel.sessions count: \(messageViewModel.sessions.count)")

                    previewsViewModel.generateAndStoreChatPreviews(
                        sessions: messageViewModel.sessions,
                        technicians: technicianViewModel.technicians
                    )
                }

                for session in messageViewModel.sessions {
                    print("[Debug] Sesión:", session.sessionId, "-> mensajes:", session.messages.count)
                }
            }
        }
    }
}
