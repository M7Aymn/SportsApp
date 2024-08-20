//
//  MockingTests.swift
//  SportsAppTests
//
//  Created by Mohamed Ayman on 20/08/2024.
//

import XCTest
@testable import SportsApp

final class MockingTests: XCTestCase {

    var mockObj: MockNetworkManager!
    
    override func setUpWithError() throws {
//        mockObj = MockNetworkManager(shouldReturnError: false)
    }
    
    override func tearDownWithError() throws {
        mockObj = nil
    }
    
    func testFetchMockData() {
        mockObj = MockNetworkManager(shouldReturnError: false)
        mockObj.fetchLeagues { leagues, error in
            if let error = error {
                XCTFail(error.localizedDescription)
            } else {
                XCTAssertNotNil(leagues)
                XCTAssertEqual(leagues!.success, 1)
                XCTAssertEqual(leagues!.result[0].leagueKey, 322)
                XCTAssertEqual(leagues!.result[0].leagueName, "Süper Lig")
                XCTAssertEqual(leagues!.result[0].countryKey, 111)
                XCTAssertEqual(leagues!.result[0].countryName, "Turkey")
            }
        }
    }
    
    func testFetchMockDataFail() {
        mockObj = MockNetworkManager(shouldReturnError: true)
        mockObj.fetchLeagues { leagues, error in
            XCTAssertNotNil(error)
            XCTAssertNil(leagues)
        }
    }
}
