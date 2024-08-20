//
//  AllSportsViewModel.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 12/08/2024.
//

import Foundation

class AllSportsViewModel {
    let connectivity: ConnectivityProtocol!
    let sports: [Sport] = [.football, .basketball, .cricket, .tennis]
    var navigateToAllLeaguesTVC: (Int)->() = {_ in}
    
    init() {
        connectivity = Connectivity.shared
    }
}
