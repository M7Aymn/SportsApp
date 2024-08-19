//
//  AllLeaguesViewModel.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 12/08/2024.
//

import Foundation

class AllLeaguesViewModel{
    var isFav : Bool = true
    var nwService : NWServiceProtocol?
    var coreDataService: CoreDataServiceProtocol?
    var sport : Sport?
    var leagues : [LeagueModel] = []
    var sports : [Sport] = [] {
        didSet {
            showNoFavoriteImage(sports.isEmpty)
        }
    }
    var bindResultToVC : (()->Void) = {}
    var showNoFavoriteImage : ((Bool)->Void) = {_ in}
    
    init() {
        self.nwService = NWService()
        self.coreDataService = CoreDataService.shared
    }
    
    
    func getFavoriteLeagues(){
        (leagues, sports) = coreDataService?.fetchLeagues() ?? ([], [])
        bindResultToVC()
    }
    
    func getLeaguesFromNetwork(){
        guard let sport = sport else {return}
        let allLeaguesURL = API.getAllLeagueURL(sport: sport)
        nwService?.fetchData(url: allLeaguesURL, model: LeagueModelAPIResponse.self, completion: { result, error in
            if let result = result {
                self.leagues = result.result
                self.bindResultToVC()
            } else {
#warning("when api was down this scope triggered")
#warning("try to stop indicator and add some photo")
                print(error!.localizedDescription)
            }
        })
    }
    
    func loadLeaguesTable(){
        if isFav{
            getFavoriteLeagues()
        } else {
            getLeaguesFromNetwork()
        }
    }
    
    func getYouTubeChannelURL(for league: LeagueModel) -> URL? {
        let leagueName = league.leagueName.replacingOccurrences(of: " ", with: "")
        let youtubeUrlString = "https://www.youtube.com/@\(leagueName)"
        return URL(string: youtubeUrlString)
    }
    
    func getNumberOfLeagues()->Int{
        return leagues.count
    }
    
    func getLeague(index: Int)->LeagueModel{
        return leagues[index]
    }
    
    func removeFromFavorites(index: Int) {
        coreDataService?.deleteLeague(key: leagues[index].leagueKey, sport: sports[index])
    }
}
