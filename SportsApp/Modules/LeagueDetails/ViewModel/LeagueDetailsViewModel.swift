//
//  LeagueDetailsViewModel.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 12/08/2024.
//

import Foundation

class LeagueDetailsViewModel {
    var nwService: NWServicing?
    var bindResultToVC: (()->()) = {}
    var upcomingEvents: [EventModel] = []
    var latestEvents: [EventModel] = []
    var teams: [Team] = []
    
    init() {
        nwService = NWService()
    }
    
    func getDetails() {
        getUpcomingEvents()
        getLatestResults()
    }
    
    private func getUpcomingEvents() {
        let upcomingURL = API.getLeagueDetailsURL(sport: .football, leagueID: 332, forDate: .comingYear)
        nwService!.fetchData(url: upcomingURL, model: EventModelAPIResponse.self) { [weak self] response in
            if response.success == 1 {
                DispatchQueue.main.async {
                    self?.upcomingEvents = response.result
                    self?.bindResultToVC()
                }
            } else {
                print("API Response error")
            }
        }
    }
    
    private func getLatestResults() {
        let latestURL = API.getLeagueDetailsURL(sport: .football, leagueID: 332, forDate: .pastYear)
        nwService!.fetchData(url: latestURL, model: EventModelAPIResponse.self) { [weak self] response in
            if response.success == 1 {
                DispatchQueue.main.async {
                    self?.latestEvents = response.result
                    self?.getTeams()
                    self?.bindResultToVC()
                }
            } else {
                print("API Response error")
            }
        }
    }
    
    private func getTeams() {
        var teams: [Team] = []
        for event in latestEvents {
            let team = Team(teamKey: event.homeTeamKey, teamName: event.eventHomeTeam, teamLogo: event.homeTeamLogo)
            teams.append(team)
        }
        self.teams = teams
        bindResultToVC()
    }
}
