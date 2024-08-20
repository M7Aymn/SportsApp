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
    static let apiKey = "&APIkey=f425b6bc70085b127f48d285251e2d85c423aa2f33cee948d703b11432bcebbb"
    
    static func getAllLeagueURL(sport: Sport) -> URL? {
        return URL(string: baseURL + sport.endpoint + leagues + apiKey)
    }
    
    static func getLeagueDetailsURL(sport: Sport, leagueID: Int, forDate range: DateRange) -> URL? {
        return URL(string: baseURL + sport.endpoint + leagueDetails + "\(leagueID)" + range.get + apiKey)
    }
    
    static func getTeamDetailsURL(sport: Sport, TeamID: Int) -> URL? {
        return URL(string: baseURL + sport.endpoint + teamDetails + "\(TeamID)" + apiKey)
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
    case prevYear
    case nextYear
    
    var get: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        
        switch self {
        case .prevYear:
            let pastYear = Calendar.current.date(byAdding: .year, value: -1, to: currentDate)!
            //            return "&from=\(formatter.string(from: pastYear))&to=\(formatter.string(from: currentDate))"
#warning("For testing perpose")
            let prevDay = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
            return "&from=\(formatter.string(from: pastYear))&to=\(formatter.string(from: prevDay))"
        case .nextYear:
            let comingYear = Calendar.current.date(byAdding: .year, value: 1, to: currentDate)!
//            return "&from=\(formatter.string(from: currentDate))&to=\(formatter.string(from: comingYear))"
            let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
            return "&from=\(formatter.string(from: nextDay))&to=\(formatter.string(from: comingYear))"
        }
    }
}
