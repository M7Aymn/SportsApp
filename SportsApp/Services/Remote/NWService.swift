//
//  NWService.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 12/08/2024.
//

import Foundation

protocol NWServiceProtocol {
    func fetchData<T: Codable>(url: URL?, model: T.Type, completion: @escaping(T)->Void)
}

class NWService: NWServiceProtocol {
    func fetchData<T: Codable>(url: URL?, model: T.Type, completion: @escaping(T)->Void) {
        guard let url = url else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                print("error with data")
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(model, from: data)
                completion(decoded)
            } catch {
                print(error.localizedDescription)
                return
            }
        }
        task.resume()
    }
}
