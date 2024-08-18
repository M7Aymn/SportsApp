//
//  Connectivity.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 18/08/2024.
//

import Foundation
import Network

class Connectivity {
    static let shared = Connectivity()
    private init() {}
    
    func check(compilation: @escaping(Bool)->()) {
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
