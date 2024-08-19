//
//  NWServiceTests.swift
//  SportsAppTests
//
//  Created by Mohamed Ayman on 18/08/2024.
//

import XCTest
@testable import SportsApp

final class NWServiceTests: XCTestCase {

    var nwService: NWServiceProtocol!
    
    override func setUpWithError() throws {
        nwService = NWService()
    }

    override func tearDownWithError() throws {
        nwService = nil
    }

    func testNetworkResponseSuccess() throws {
        let sport = Sport.football
        let allLeaguesURL = API.getAllLeagueURL(sport: sport)
        
        let expectedObject = XCTestExpectation(description: "waiting for API response")
        nwService?.fetchData(url: allLeaguesURL, model: LeagueModelAPIResponse.self, completion: { result, error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            if let result = result {
                XCTAssertEqual(result.success, 1)
                expectedObject.fulfill()
            } else {
                XCTFail("No result returned")
            }
        })
        wait(for: [expectedObject],timeout: 10)
    }
    
    func testNetworkWrongModelFailure() throws {
        let sport = Sport.football
        let leagueID = 332
        let nextYearDateRange = DateRange.nextYear
        let prevYearDateRange = DateRange.prevYear
        let wrongModel = TeamModel.self
        let leagueDetailsURL = API.getLeagueDetailsURL(sport: sport, leagueID: leagueID, forDate: nextYearDateRange)
        let _ = API.getLeagueDetailsURL(sport: sport, leagueID: leagueID, forDate: prevYearDateRange)
        
        let expectedObject = XCTestExpectation(description: "waiting for API response")
        nwService?.fetchData(url: leagueDetailsURL, model: wrongModel, completion: { result, error in
            XCTAssertNotNil(error)
            XCTAssertNil(result)
            expectedObject.fulfill()
        })
        wait(for: [expectedObject],timeout: 10)
    }

    func testNetworkNoURLFailure() throws {
        let _ = API.getTeamDetailsURL(sport: .football, TeamID: 332)
        
        let expectedObject = XCTestExpectation(description: "waiting for API response")
        nwService?.fetchData(url: nil, model: TeamModel.self, completion: { result, error in
            if let error = error {
                XCTAssertEqual((error as NSError).domain , "URL error")
                expectedObject.fulfill()
            }
        })
        wait(for: [expectedObject],timeout: 10)
    }

}
