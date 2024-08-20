//
//  LeagueDetailsViewModelTests.swift
//  SportsAppTests
//
//  Created by Mohamed Ayman on 19/08/2024.
//

import XCTest
@testable import SportsApp

final class LeagueDetailsViewModelTests: XCTestCase {

    var viewModel: LeagueDetailsViewModel!
    
    override func setUpWithError() throws {
        viewModel = LeagueDetailsViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testUpcomingEvents() throws {
        let expectation = XCTestExpectation(description: "Fetch upcoming events")
        viewModel.bindResultToVC = {
            XCTAssertGreaterThan(self.viewModel.upcomingEvents.count, 0)
            expectation.fulfill()
        }
        viewModel.getUpcomingEvents()
        wait(for: [expectation],timeout: 10)
    }
    
    func testLatestEvents() throws {
        let expectation = XCTestExpectation(description: "Fetch latest events")
        viewModel.bindResultToVC = {
            XCTAssertGreaterThan(self.viewModel.latestEvents.count, 0)
            expectation.fulfill()
        }
        viewModel.getLatestResults()
        wait(for: [expectation],timeout: 10)
    }

    func testGetTeams() throws {
        let expectation = XCTestExpectation(description: "Generating teams")
        viewModel.latestEvents = [EventModel(homeTeamLogo: "logo", eventHomeTeam: "name", homeTeamKey: 10, awayTeamLogo: nil, eventAwayTeam: nil, awayTeamKey: 0, leagueLogo: nil, eventFinalResult: nil, eventDate: nil, eventTime: nil)]
        viewModel.bindResultToVC = {
            XCTAssertEqual(self.viewModel.teams[0].teamName, "name")
            XCTAssertEqual(self.viewModel.teams[0].teamLogo, "logo")
            XCTAssertEqual(self.viewModel.teams[0].teamKey, 10)
            expectation.fulfill()
        }
        viewModel.getTeams()
        wait(for: [expectation],timeout: 2)
    }
    
    func testGetFullDetails() throws {
        viewModel.league = LeagueModel(leagueKey: 332, leagueName: "Test", countryKey: nil, countryName: nil, leagueLogo: nil, countryLogo: nil, leagueYear: nil)
        
        let expectation = XCTestExpectation(description: "Fetching all events")
        viewModel.bindResultToVC = {
            if self.viewModel.doneRequests == [1, 1] {
                expectation.fulfill()
            }
        }
        self.viewModel.getDetails()
        wait(for: [expectation],timeout: 10)
    }
    
    func testFavorite() throws {
        viewModel.league = LeagueModel(leagueKey: -1, leagueName: "Test", countryKey: nil, countryName: nil, leagueLogo: nil, countryLogo: nil, leagueYear: nil)
        XCTAssertFalse(viewModel.checkFavorite())
        viewModel.addToFavorites()
        XCTAssertTrue(viewModel.checkFavorite())
        viewModel.removeFromFavorites()
        XCTAssertFalse(viewModel.checkFavorite())
    }
    
    func testNoUpcomingResult() throws {
        viewModel.league = LeagueModel(leagueKey: 28, leagueName: "World cup", countryKey: nil, countryName: nil, leagueLogo: nil, countryLogo: nil, leagueYear: nil)
        
        let expectation = XCTestExpectation(description: "No upcoming events test")
        viewModel.bindResultToVC = {
            XCTAssertEqual(self.viewModel.doneRequests[0], 1)
            expectation.fulfill()
        }
        self.viewModel.getUpcomingEvents()
        wait(for: [expectation],timeout: 5)
    }
    
    func testNoLatestResult() throws {
        viewModel.league = LeagueModel(leagueKey: 28, leagueName: "World cup", countryKey: nil, countryName: nil, leagueLogo: nil, countryLogo: nil, leagueYear: nil)
        
        let expectation = XCTestExpectation(description: "No latest events test")
        viewModel.bindResultToVC = {
            XCTAssertEqual(self.viewModel.doneRequests[1], 1)
            expectation.fulfill()
        }
        self.viewModel.getLatestResults()
        wait(for: [expectation],timeout: 5)
    }

}

