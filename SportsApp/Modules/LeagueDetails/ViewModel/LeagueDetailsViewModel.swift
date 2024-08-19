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
    var sport: Sport = .football
    var league: LeagueModel
    var upcomingEvents: [EventModel] = []
    var latestEvents: [EventModel] = []
    var teams: [TeamModel] = []
    var bindResultToVC: (()->()) = {}
    var stopIndicator: (()->()) = {}
    
    var doneRequests = [0, 0] {
        didSet {
            bindResultToVC()
            if doneRequests.reduce(0, +) == 2 {
                stopIndicator()
            }
        }
    }
    
    init() {
        nwService = NWService()
        coreDataService = CoreDataService.shared
        league = LeagueModel(leagueKey: 332, leagueName: "MLS", countryKey: nil, countryName: nil, leagueLogo: nil, countryLogo: nil, leagueYear: nil)
    }
    
    func getDetails() {
        getUpcomingEvents()
        getLatestResults()
    }
    
    func getUpcomingEvents() {
        let upcomingURL = API.getLeagueDetailsURL(sport: sport, leagueID: league.leagueKey, forDate: .nextYear)
        nwService.fetchData(url: upcomingURL, model: EventModelAPIResponse.self) { [weak self] response, error in
            if let error = error {
                print(error.localizedDescription)
                self?.doneRequests[0] = 1
                return
            }
            guard let response = response else {
                print("No data in response")
                self?.doneRequests[0] = 1
                return
            }
            self?.upcomingEvents = response.result
            self?.doneRequests[0] = 1
        }
    }
    
    func getLatestResults() {
        let latestURL = API.getLeagueDetailsURL(sport: sport, leagueID: league.leagueKey, forDate: .prevYear)
        nwService.fetchData(url: latestURL, model: EventModelAPIResponse.self) { [weak self] response, error in
            if let error = error {
                print(error.localizedDescription)
                self?.doneRequests[1] = 1
                return
            }
            guard let response = response else {
                print("No data in response")
                self?.doneRequests[1] = 1
                return
            }
            self?.latestEvents = response.result
            self?.getTeams()
            self?.doneRequests[1] = 1
        }
    }
    
    func getTeams() {
        teams = TeamsFromEventGenerator.getTeams(events: latestEvents)
        self.bindResultToVC()
    }
    
    func addToFavorites() {
        coreDataService.addLeague(league: league, sport: sport)
    }
    
    func removeFromFavorites() {
        coreDataService.deleteLeague(key: league.leagueKey, sport: sport)
    }
    
    func checkFavorite() -> Bool {
        return coreDataService.checkFav(key: league.leagueKey, sport: sport)
    }
}
