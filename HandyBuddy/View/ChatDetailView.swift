//
//  ChatDetailView.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 09/05/25.
//

import SwiftUI

struct ChatDetailView: View {
    let session: MessageSessionLocal?
    let technician: ChatPreviewLocal

    var body: some View {
        VStack {
            HStack(spacing: 12) {
                if let url = URL(string: technician.imageName) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 40, height: 40)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                        case .failure:
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }

                VStack(alignment: .leading) {
                    Text("\(technician.name) \(technician.lastName)")
                        .font(.headline)
                }

                Spacer()
            }
            .padding()

            Divider()

            ScrollView {
                VStack(spacing: 12) {
                    var sortedMessages: [MessageLocal] {
                        session?.messages.sorted(by: {
                            guard
                                let date1 = ISO8601DateFormatter().date(from: $0.timestamp),
                                let date2 = ISO8601DateFormatter().date(from: $1.timestamp)
                            else { return false }
                            return date1 < date2
                        }) ?? []
                    }

                    ForEach(sortedMessages) { message in
                        MessageBubbleView(message: message, technicianImage: technician.imageName)
                    }
                }
                .padding()
            }

            Spacer()
        }
        .navigationTitle(Text("chat_detail_title"))
        .navigationBarTitleDisplayMode(.inline)
    }
}
