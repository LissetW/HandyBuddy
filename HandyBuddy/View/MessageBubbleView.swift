//
//  MessageBubbleView.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 03/07/25.
//

import SwiftUI

struct MessageBubbleView: View {
    let message: MessageLocal
    let technicianImage: String

    var isFromUser: Bool {
        message.sender == "user"
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if !isFromUser {
                if let url = URL(string: technicianImage), !technicianImage.isEmpty {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 30, height: 30)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                        case .failure:
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.gray)
                }
            }

            VStack(alignment: isFromUser ? .trailing : .leading, spacing: 4) {
                Text(message.content)
                    .padding(10)
                    .background(isFromUser ? Color.blue : Color.gray.opacity(0.2))
                    .foregroundColor(isFromUser ? .white : .black)
                    .cornerRadius(16)
                    .frame(maxWidth: .infinity, alignment: isFromUser ? .trailing : .leading)

                Text(formatTime(from: message.timestamp))
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(isFromUser ? .trailing : .leading, 10)
            }

            if isFromUser {
                // Espacio para mantener simetría
                Spacer().frame(width: 30)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }

    private func formatTime(from isoString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: isoString) {
            let output = DateFormatter()
            output.timeStyle = .short
            return output.string(from: date)
        }
        return ""
    }
}
