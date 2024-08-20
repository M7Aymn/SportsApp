//
//  TeamDetailsViewModelTests.swift
//  SportsAppTests
//
//  Created by Ahmed Ashraf on 19/08/2024.
//

import XCTest
@testable import SportsApp
final class TeamDetailsViewModelTests: XCTestCase {

    var viewModel: TeamDetailsViewModel!
        
        override func setUpWithError() throws {
            viewModel = TeamDetailsViewModel()
        }

        override func tearDownWithError() throws {
            viewModel = nil
        }

        func testTeamDetails() throws {
            let expectation = XCTestExpectation(description: "Fetching team details test")
            viewModel.sport = .football
            viewModel.teamID = 2322
            viewModel.bindResultToViewController = {
                XCTAssertEqual(self.viewModel.getPlayersCount(), 18)
                XCTAssertEqual(self.viewModel.getPlayer(index: 10).playerKey, 2199199348)
                XCTAssertEqual(self.viewModel.getSportType(), .football)
                expectation.fulfill()
            }
            viewModel.getTeamDetails()
            wait(for: [expectation], timeout: 10)
        }
        
        func testNoResultFound() throws {
            let expectation = XCTestExpectation(description: "No team details result test")
            viewModel.sport = .football
            viewModel.teamID = 99999
            viewModel.noResultFound = {
                expectation.fulfill()
            }
            viewModel.getTeamDetails()
            wait(for: [expectation], timeout: 10)
        }


}
