//
//  TeamsFromEventGenerator.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 20/08/2024.
//

import Foundation

struct TeamsFromEventGenerator {
    static func getTeams(events: [EventModel]) -> [TeamModel] {
        var teams: [TeamModel] = []
        var teamsKey: Set<Int> = []
        for event in events {
            if !teamsKey.contains(event.homeTeamKey) {
                let team = TeamModel(teamKey: event.homeTeamKey, teamName: event.eventHomeTeam ?? "", teamLogo: event.homeTeamLogo, players: nil, coaches: nil)
                teams.append(team)
                teamsKey.insert(event.homeTeamKey)
            }
            if !teamsKey.contains(event.awayTeamKey) {
                let team = TeamModel(teamKey: event.awayTeamKey, teamName: event.eventAwayTeam ?? "", teamLogo: event.awayTeamLogo, players: nil, coaches: nil)
                teams.append(team)
                teamsKey.insert(event.awayTeamKey)
            }
        }
        return teams
    }
}
