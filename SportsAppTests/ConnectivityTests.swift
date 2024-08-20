//
//  ConnectivityTests.swift
//  SportsAppTests
//
//  Created by Mohamed Ayman on 18/08/2024.
//

import XCTest
@testable import SportsApp

final class ConnectivityTests: XCTestCase {

    var connectivity: ConnectivityProtocol!
    
    override func setUpWithError() throws {
        connectivity = Connectivity.shared
    }

    override func tearDownWithError() throws {
        connectivity = nil
    }

    func testConnectivity() throws {
        let expectedObject = XCTestExpectation(description: "waiting for connection status")
        connectivity.checkConnectivity { _ in
            expectedObject.fulfill()
        }
        wait(for: [expectedObject], timeout: 3)
    }

}
