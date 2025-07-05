//
//  NetworkMonitor.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 03/07/25.
//


import Network
import Combine

final class NetworkMonitor: ObservableObject {
    static let shared = NetworkMonitor()

    @Published private(set) var isConnected: Bool = true
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            let status = path.status == .satisfied
            DispatchQueue.main.async {
                self?.isConnected = status
                print("[Network] conectado:", status)
            }
        }
        monitor.start(queue: queue)
    }
}
