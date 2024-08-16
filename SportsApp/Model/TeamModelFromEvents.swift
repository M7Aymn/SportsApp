//
//  TeamModelFromEvents.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 13/08/2024.
//

import Foundation

struct TeamModelFromEvents {
    let teamKey: Int
    let teamName: String
    let teamLogo: String
}

struct TeamsFromEventGenerator {
    static func getTeams(events: [EventModel]) -> [TeamModelFromEvents] {
        var teams: [TeamModelFromEvents] = []
        var teamsKey: Set<Int> = []
        for event in events {
            if !teamsKey.contains(event.homeTeamKey) {
                teams.append(TeamModelFromEvents(teamKey: event.homeTeamKey, teamName: event.eventHomeTeam ?? "", teamLogo: event.homeTeamLogo ?? ""))
                teamsKey.insert(event.homeTeamKey)
            }
        }
        return teams
    }
}
