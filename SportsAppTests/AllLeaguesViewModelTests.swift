//
//  AllLeaguesViewModelTests.swift
//  SportsAppTests
//
//  Created by Ahmed Ashraf on 19/08/2024.
//

import XCTest
@testable import SportsApp

final class AllLeaguesViewModelTests: XCTestCase {

    var viewModel: AllLeaguesViewModel!
        
        override func setUpWithError() throws {
            viewModel = AllLeaguesViewModel()
            viewModel.sport = .football
        }

        override func tearDownWithError() throws {
            viewModel = nil
        }

        func testNetwork() throws {
            let expectation = XCTestExpectation(description: "Network test")
            viewModel.isFav = false
            viewModel.bindResultToVC = {
                XCTAssertGreaterThan(self.viewModel.getNumberOfLeagues(), 0)
                XCTAssertEqual(self.viewModel.getLeague(index: 0).leagueKey, 4)
                XCTAssertNotNil(self.viewModel.getYouTubeChannelURL(for: self.viewModel.leagues[0]))
                expectation.fulfill()
            }
            viewModel.getLeaguesFromNetwork()
            wait(for: [expectation],timeout: 10)
        }
        
        func testFavorite() throws {
            let expectation = XCTestExpectation(description: "Favorite test")
            viewModel.isFav = true
            XCTAssertTrue(viewModel.isFav)
            viewModel.coreDataService?.addLeague(league: LeagueModel(leagueKey: 332, leagueName: "Test", countryKey: nil, countryName: nil, leagueLogo: nil, countryLogo: nil, leagueYear: nil), sport: .football)
            viewModel.bindResultToVC = {
                XCTAssertGreaterThan(self.viewModel.getNumberOfLeagues(), 0)
                XCTAssertEqual(self.viewModel.leagues.last!.leagueKey, 332)
                expectation.fulfill()
            }
            viewModel.getFavoriteLeagues()
            wait(for: [expectation],timeout: 2)
        }
        
        func testLoadFavoriteTable() {
            let expectation = XCTestExpectation(description: "Loading favorites")
            viewModel.isFav = true
            viewModel.bindResultToVC = {
                expectation.fulfill()
            }
            viewModel.loadLeaguesTable()
            wait(for: [expectation],timeout: 2)
        }
        
        func testLoadNetworkTable() {
            let expectation = XCTestExpectation(description: "Fetching network data")
            viewModel.isFav = false
            viewModel.sport = .football
            viewModel.bindResultToVC = {
                expectation.fulfill()
            }
            viewModel.loadLeaguesTable()
            wait(for: [expectation],timeout: 10)
        }
        
        func testRemoveFromFavorite() {
            let league = LeagueModel(leagueKey: 242, leagueName: "Removing favorite item", countryKey: nil, countryName: nil, leagueLogo: nil, countryLogo: nil, leagueYear: nil)
            let favCount = CoreDataService.shared.fetchLeagues().0.count
            CoreDataService.shared.addLeague(league: league, sport: .basketball)
            XCTAssertEqual(CoreDataService.shared.fetchLeagues().0.count, favCount + 1)
            
            viewModel.leagues = [league]
            viewModel.sports = [.basketball]
            viewModel.removeFromFavorites(index: 0)
            XCTAssertEqual(CoreDataService.shared.fetchLeagues().0.count, favCount)
            XCTAssertFalse(CoreDataService.shared.checkFav(leagueKey: 242, sport: .basketball))
        }


}
