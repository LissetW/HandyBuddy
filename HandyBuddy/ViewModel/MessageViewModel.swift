//
//  MessageViewModel.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 15/06/25.
//

import SwiftUI
import SwiftData
import Network

@MainActor
class MessageViewModel: ObservableObject {
    @Published var sessions: [MessageSessionLocal] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    private var context: ModelContext?

    func setContextIfNeeded(_ newContext: ModelContext) {
        if context == nil {
            context = newContext
        }
    }

    func fetchSessions() async {
        guard let context else {
            errorMessage = "Missing SwiftData context"
            return
        }

        if NetworkMonitor.shared.isConnected {
            await fetchRemoteSessions(using: context)
        } else {
            loadLocalSessions(using: context)
            errorMessage = "Offline. Showing local messages."
        }
    }

    private func loadLocalSessions(using context: ModelContext) {
        let request = FetchDescriptor<MessageSessionLocal>(
            sortBy: [SortDescriptor(\.sessionId)]
        )

        do {
            let localSessions = try context.fetch(request)

            // Fuerza la carga de los mensajes asociados
            for session in localSessions {
                _ = session.messages.count
                print("[Debug] Sesión:", session.sessionId, "-> mensajes:", session.messages.count)
            }

            self.sessions = localSessions
            print("[MessageVM] Loaded local sessions count: \(sessions.count)")
        } catch {
            errorMessage = "Failed to load local sessions: \(error.localizedDescription)"
            print("[MessageVM] Failed to load local sessions: \(error)")
        }
    }

    private func fetchRemoteSessions(using context: ModelContext) async {
        guard let url = URL(string: "https://handy-buddy.free.beeceptor.com/messages") else {
            errorMessage = "Invalid URL"
            return
        }

        do {
            isLoading = true
            let (data, _) = try await URLSession.shared.data(from: url)
            let remoteSessions = try JSONDecoder().decode([MessageSession].self, from: data)
            print("[MessageVM] Remote sessions count: \(remoteSessions.count)")

            // Elimina todas las sesiones locales existentes
            for existing in try context.fetch(FetchDescriptor<MessageSessionLocal>()) {
                context.delete(existing)
            }

            // Inserta sesiones nuevas con sus mensajes
            for session in remoteSessions {
                let localSession = MessageSessionLocal(sessionId: session.sessionId)
                context.insert(localSession)

                for msg in session.messages {
                    let localMsg = MessageLocal(
                        id: msg.id,
                        sender: msg.sender,
                        timestamp: msg.timestamp,
                        content: msg.content
                    )
                    context.insert(localMsg)
                    localSession.messages.append(localMsg)
                }
            }

            try context.save()
            print("[MessageVM] Context saved")

            // Carga las sesiones desde SwiftData ya persistidas
            loadLocalSessions(using: context)
            errorMessage = nil
        } catch {
            errorMessage = "Failed to fetch messages: \(error.localizedDescription)"
            loadLocalSessions(using: context)
            print("[MessageVM] Error fetching remote sessions: \(error)")
        }

        isLoading = false
    }
}
