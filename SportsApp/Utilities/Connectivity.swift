//
//  Connectivity.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 18/08/2024.
//

import Foundation
import Network

protocol ConnectivityProtocol {
    func checkConnectivity(compilation: @escaping(Bool)->())
}

class Connectivity: ConnectivityProtocol {
    static let shared = Connectivity()
    private init() {}
    
    func checkConnectivity(compilation: @escaping(Bool)->()) {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            let status = path.status == .satisfied
            DispatchQueue.main.async {
                compilation(status)
            }
            monitor.cancel()
        }
        monitor.start(queue: .main)
    }
}
