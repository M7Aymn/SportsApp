//
//  API.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 13/08/2024.
//

import Foundation

struct API {
    static let baseURL = "https://apiv2.allsportsapi.com"
    static let leagues = "/?met=Leagues"
    static let leagueDetails = "/?met=Fixtures&leagueId="
    static let apiKey = "&APIkey=f425b6bc70085b127f48d285251e2d85c423aa2f33cee948d703b11432bcebbb"
    
    static func getAllLeagueURL(sport: Sport) -> URL? {
        return URL(string: baseURL + sport.endpoint + leagues + apiKey)
    }
    
    static func getLeagueDetailsURL(sport: Sport, leagueID: Int, forDate range: DateRange) -> URL? {
        return URL(string: baseURL + sport.endpoint + leagueDetails + "\(leagueID)" + range.rawValue + apiKey)
    }
}

enum Sport: String {
    case football = "Football"
    case basketball = "Basketball"
    case cricket = "Cricket"
    case tennis = "Tennis"
    
    var endpoint: String {
        return "/" + self.rawValue.lowercased()
    }
    
    var title: String {
        return self.rawValue
    }
    
    var imageName: String {
        return self.rawValue.lowercased()
    }
}

enum DateRange: String {
    case pastYear = "&from=2023-08-20&to=2024-08-20"
    case comingYear = "&from=2024-08-20&to=2025-08-20"
}
