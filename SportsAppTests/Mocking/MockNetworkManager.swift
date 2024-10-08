//
//  MockNetworkManager.swift
//  SportsAppTests
//
//  Created by Mohamed Ayman on 20/08/2024.
//

import XCTest
@testable import SportsApp

class MockNetworkManager {
    
    var shouldReturnError: Bool
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    let fakeJSONObj: [String : Any] =
    [
        "success": 1,
        "result": [
            [
                "league_key": 322,
                "league_name": "Süper Lig",
                "country_key": 111,
                "country_name": "Turkey",
                "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/322_süper-lig.png",
                "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/111_turkey.png"
            ]
        ]
    ]
    
}

extension MockNetworkManager {
    
    func fetchLeagues(completionHandler: @escaping (LeagueModelAPIResponse?, Error?) -> Void) {
        
        var result = LeagueModelAPIResponse(success: 0, result: [])
        
        enum responseWithError: Error {
            case decodingError
            case responseError
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: fakeJSONObj)
            result = try JSONDecoder().decode(LeagueModelAPIResponse.self, from: data)
            
        } catch let error {
            print(error.localizedDescription)
            completionHandler(nil, responseWithError.decodingError)
        }
        
        if shouldReturnError {
            completionHandler(nil, responseWithError.responseError)
        } else {
            completionHandler(result, nil)
        }
        
    }
}
