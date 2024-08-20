//
//  AllLeaguesViewModel.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 12/08/2024.
//

import Foundation

class AllLeaguesViewModel{
    let networkService: NetworkServiceProtocol!
    let coreDataService: CoreDataServiceProtocol!
    let connectivity: ConnectivityProtocol!
    var isFav: Bool = true
    var leagues: [LeagueModel] = []
    var sport: Sport?
    var sports: [Sport] = [] {
        didSet {
            showNoFavoriteImage(sports.isEmpty)
        }
    }
    var bindResultToVC: (()->()) = {}
    var showNoFavoriteImage: ((Bool)->()) = {_ in}
    
    init() {
        networkService = NetworkService()
        coreDataService = CoreDataService.shared
        connectivity = Connectivity.shared
    }
    
    func loadLeaguesTable() {
        if isFav {
            getFavoriteLeagues()
        } else {
            getLeaguesFromNetwork()
        }
    }
    
    func getFavoriteLeagues() {
        (leagues, sports) = coreDataService.fetchLeagues()
        bindResultToVC()
    }
    
    func getLeaguesFromNetwork() {
        guard let sport = sport else {return}
        let allLeaguesURL = API.getAllLeagueURL(sport: sport)
        networkService?.fetchData(url: allLeaguesURL, model: LeagueModelAPIResponse.self) { result, error in
            if let result = result {
                self.leagues = result.result
                self.bindResultToVC()
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    func getYouTubeChannelURL(for index: Int) -> URL? {
        let leagueName = leagues[index].leagueName.replacingOccurrences(of: " ", with: "")
        let youtubeUrlString = "https://www.youtube.com/@\(leagueName)"
        return URL(string: youtubeUrlString)
    }
    
    func getNumberOfLeagues() -> Int {
        return leagues.count
    }
    
    func getLeague(index: Int) -> LeagueModel {
        return leagues[index]
    }
    
    func removeFromFavorites(index: Int) {
        coreDataService?.deleteLeague(leagueKey: leagues[index].leagueKey, sport: sports[index])
    }
}
