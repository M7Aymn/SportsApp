//
//  TeamDetailsViewModel.swift
//  SportsApp
//
//  Created by Ahmed Ashraf on 16/08/2024.
//

import Foundation


class TeamDetailsViewModel {
    var sport : Sport?
    var teamID : Int?
    var nwService : NWServiceProtocol!
    var team : [TeamModel] = [] {
        didSet{
            self.players = team[0].players ?? []
            bindResultToViewController()
        }
    }
    var players : [Player] = []
    var bindResultToViewController : (()->Void) = {}
    var noResultFound : (()->Void) = {}
    
    init(){
        nwService = NWService()
    }
    
    func getTeamDetails() {
        guard let sport = sport else {return}
        guard let teamID = teamID else {return}
        guard let url = API.getTeamDetailsURL(sport: sport, TeamID: teamID) else {return}
        nwService.fetchData(url: url, model: TeamModelAPIResponse.self) { result, error in
            if error != nil {
                self.noResultFound()
            }
            if let result = result{
                self.team = result.result
                if self.team[0].players == nil || self.team[0].players!.isEmpty {
                    self.noResultFound()
                }
            } else {
                print(error!)
                self.noResultFound()
            }
            
        }
    }
    
    func getPlayersCount() -> Int? {
        return players.count
    }
    
    func getPlayer(index: Int) -> Player {
        return players[index]
    }
    
    func getSportType() -> Sport {
        return sport!
    }
}
