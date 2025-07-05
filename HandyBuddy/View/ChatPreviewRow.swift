//
//  ChatPreviewRow.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 03/07/25.
//

import SwiftUI

struct ChatPreviewRow: View {
    let chat: ChatPreviewLocal

    var body: some View {
        HStack(spacing: 12) {
            if let url = URL(string: chat.imageName) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 50, height: 50)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    case .failure:
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("\(chat.name) \(chat.lastName)")
                    .font(.headline)
                Text(chat.lastMessage)
                    .font(.caption)
                    .lineLimit(1)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Text(chat.lastMessageDate)
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}
