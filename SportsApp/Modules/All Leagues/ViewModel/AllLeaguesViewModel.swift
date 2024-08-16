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
    var bindResultToVC : (()->Void) = {}
    
    init() {
        self.nwService = NWService()
        self.coreDataService = CoreDataService.shared
    }
    
    func isFavouriteScreen() -> Bool {return isFav}
    
    func getFavouriteLeagues(){
        leagues = coreDataService?.fetchLeagues() ?? []
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
                print(error!.localizedDescription)
            }
        })
    }
    
    func getYouTubeChannelURL(for league: LeagueModel) -> URL? {
        let leagueName = league.leagueName.replacingOccurrences(of: " ", with: "")
        let youtubeUrlString = "https://www.youtube.com/@\(leagueName)"
        return URL(string: youtubeUrlString)
    }
    
    func getNumberOfleagues()->Int{
        return leagues.count
    }
    
    func getLeague(index: Int)->LeagueModel{
        return leagues[index]
    }
    
}
