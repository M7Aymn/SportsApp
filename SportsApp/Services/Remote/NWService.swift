//
//  NWService.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 12/08/2024.
//

import Foundation
import Alamofire

protocol NWServiceProtocol {
    func fetchData<T: Codable>(url: URL?, model: T.Type, completion: @escaping (T?,Error?)->Void)
}

class NWService: NWServiceProtocol {
    func fetchData<T: Codable>(url: URL?, model: T.Type, completion: @escaping (T?,Error?)->Void) {
        guard let url = url else {
            let error = NSError(domain: "URL error", code: 0, userInfo: [NSLocalizedDescriptionKey : "URL is nil"])
            completion(nil,error)
            return
        }
        AF.request(url).validate().responseDecodable(of: model.self) { response in
            switch response.result{
            case .success(let decodedResult):
                completion(decodedResult,nil)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil,error)
            }
        }
    }
}
