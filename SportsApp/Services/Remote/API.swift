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
    static let teamDetails = "/?&met=Teams&teamId="
    static let apiKey = "&APIkey=" + token
    static let token = "f425b6bc70085b127f48d285251e2d85c423aa2f33cee948d703b11432bcebbb"
    
    static func getAllLeagueURL(sport: Sport) -> URL? {
        return URL(string: baseURL + sport.endpoint + leagues + apiKey)
    }
    
    static func getLeagueDetailsURL(sport: Sport, leagueID: Int, forDate range: DateRange) -> URL? {
        return URL(string: baseURL + sport.endpoint + leagueDetails + "\(leagueID)" + range.query + apiKey)
    }
    
    static func getTeamDetailsURL(sport: Sport, teamID: Int) -> URL? {
        return URL(string: baseURL + sport.endpoint + teamDetails + "\(teamID)" + apiKey)
    }
}
