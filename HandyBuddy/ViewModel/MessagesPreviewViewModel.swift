//
//  MessagesPreviewViewModel.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 04/07/25.
//


import Foundation
import SwiftUI
import SwiftData

@MainActor
class MessagesPreviewViewModel: ObservableObject {
    @Published var chatPreviews: [ChatPreviewLocal] = []
    @Published var errorMessage: String?

    private var context: ModelContext?
    
    func setContextIfNeeded(_ context: ModelContext) {
        if self.context == nil {
            self.context = context
        }
    }

    func generateAndStoreChatPreviews(
        sessions: [MessageSessionLocal],
        technicians: [Technician]
    ) {
        guard let context else {
            errorMessage = "Context not set"
            return
        }

        var newPreviews: [ChatPreviewLocal] = []

        for session in sessions {
            guard let lastMessage = session.messages.last else { continue }

            let technicianId = lastMessage.sender != "user"
                ? lastMessage.sender
                : session.messages.first(where: { $0.sender != "user" })?.sender

            guard
                let technicianId,
                let tech = technicians.first(where: { $0.id == technicianId })
            else {
                continue
            }

            let preview = ChatPreviewLocal(
                id: session.sessionId,
                name: tech.name ?? "Unknown",
                lastName: tech.lastName ?? "Unknown",
                imageName: tech.image ?? "",
                lastMessage: lastMessage.content,
                lastMessageDate: lastMessage.timestamp,
                fullMessageSession: session
            )
            print("[Debug] Insertado ChatPreview para sesión:", preview.id)

            context.insert(preview)
            newPreviews.append(preview)
        }

        do {
            try context.save()
            self.chatPreviews = newPreviews
        } catch {
            errorMessage = "Failed to save previews: \(error.localizedDescription)"
        }
        print("[Debug] Generando chat previews…")
        print("[Debug] Total sesiones recibidas:", sessions.count)
        print("[Debug] Total técnicos recibidos:", technicians.count)
        print("[Debug] ChatPreviews guardados en SwiftData.")
    }

    func loadCachedPreviews() {
        guard let context else {
            errorMessage = "Context not set"
            return
        }

        let request = FetchDescriptor<ChatPreviewLocal>(
            sortBy: [SortDescriptor(\.lastMessageDate, order: .reverse)]
        )

        do {
            chatPreviews = try context.fetch(request)
        } catch {
            errorMessage = "Failed to fetch local previews: \(error.localizedDescription)"
        }
    }
}
