//
//  LeagueDetailsViewModel.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 12/08/2024.
//

import Foundation

class LeagueDetailsViewModel {
    var nwService: NWServiceProtocol
    var coreDataService: CoreDataServiceProtocol
    var league: LeagueModel = LeagueModel(leagueKey: 332, leagueName: "Test", countryKey: 1, countryName: "Test", leagueLogo: "Test", countryLogo: "Test", leagueYear: "Test")
    var upcomingEvents: [EventModel] = []
    var latestEvents: [EventModel] = []
    var teams: [Team] = []
    var bindResultToVC: (()->()) = {}
    var startIndicator: (()->()) = {}
    var stopIndicator: (()->()) = {}
    var noResults: (()->()) = {}
    
    var remainingFailures = 2 {
        didSet {
            if remainingFailures == 0 {
                noResults()
            }
        }
    }

    init() {
        nwService = NWService()
        coreDataService = CoreDataService.shared
    }
    
#warning("TODO: Receive sport type and league key")
    func getDetails() {
        getUpcomingEvents()
        getLatestResults()
    }
    
    private func getUpcomingEvents() {
        startIndicator()
        let upcomingURL = API.getLeagueDetailsURL(sport: .football, leagueID: league.leagueKey, forDate: .nextYear)
        nwService.fetchData(url: upcomingURL, model: EventModelAPIResponse.self) { [weak self] response, error in
            if let error = error {
                print(error.localizedDescription)
                self?.remainingFailures -= 1
                return
            }
            guard let response = response else {
                print("No data in response")
                self?.remainingFailures -= 1
                return
            }
            self?.upcomingEvents = response.result
            DispatchQueue.main.async {
                self?.bindResultToVC()
                self?.stopIndicator()
            }
        }
    }
    
    private func getLatestResults() {
        startIndicator()
        let latestURL = API.getLeagueDetailsURL(sport: .football, leagueID: league.leagueKey, forDate: .prevYear)
        nwService.fetchData(url: latestURL, model: EventModelAPIResponse.self) { [weak self] response, error in
            if let error = error {
                print(error.localizedDescription)
                self?.remainingFailures -= 1
                return
            }
            guard let response = response else {
                print("No data in response")
                self?.remainingFailures -= 1
                return
            }
            self?.latestEvents = response.result
            self?.getTeams()
            DispatchQueue.main.async {
                self?.bindResultToVC()
                self?.stopIndicator()
            }
        }
    }
    
    private func getTeams() {
        var teams: [Team] = []
        for event in latestEvents {
            let team = Team(teamKey: event.homeTeamKey, teamName: event.eventHomeTeam ?? "", teamLogo: event.homeTeamLogo ?? "")
            teams.append(team)
        }
        self.teams = teams
        DispatchQueue.main.async {
            self.bindResultToVC()
        }
    }
    
    func addToFavorites() {
        coreDataService.addLeague(league: league)
    }
    
    func removeFromFavorites() {
        coreDataService.deleteLeague(key: league.leagueKey)
    }
    
    func checkFavorite() -> Bool {
        return coreDataService.checkFav(key: league.leagueKey)
    }
}
