//
//  TeamModel.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 13/08/2024.
//

import Foundation

struct Team {
    let teamKey: Int
    let teamName: String
    let teamLogo: String
}

struct Teams {
    static func getTeams(events: [EventModel]) -> [Team] {
        var teams: [Team] = []
        for event in events {
            teams.append(Team(teamKey: event.homeTeamKey, teamName: event.eventHomeTeam ?? "", teamLogo: event.homeTeamLogo ?? ""))
        }
        return teams
    }
}
