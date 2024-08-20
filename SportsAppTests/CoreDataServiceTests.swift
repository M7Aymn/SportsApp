//
//  CoreDataServiceTests.swift
//  SportsAppTests
//
//  Created by Mohamed Ayman on 18/08/2024.
//

import XCTest
import CoreData
@testable import SportsApp

final class CoreDataServiceTests: XCTestCase {
    
    var coreDataService: CoreDataServiceProtocol!
    
    override func setUpWithError() throws {
        coreDataService = CoreDataService.shared
        clearCache()
    }
    
    override func tearDownWithError() throws {
        clearCache()
        coreDataService = nil
    }
    
    func clearCache() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"LeagueEntity")
        do {
            let leagues = try managedContext.fetch(fetchRequest)
            for league in leagues {
                managedContext.delete(league)
            }
            try managedContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func testSavingNewLeague() {
        XCTAssertEqual(coreDataService.fetchLeagues().0.count, 0)
        let league = LeagueModel(leagueKey: 1, leagueName: "Test", countryKey: nil, countryName: nil, leagueLogo: nil, countryLogo: nil, leagueYear: nil)
        coreDataService.addLeague(league: league, sport: .football)
        XCTAssertEqual(coreDataService.fetchLeagues().0.count, 1)
        XCTAssertEqual(coreDataService.fetchLeagues().0.first?.leagueName, "Test")
        XCTAssertEqual(coreDataService.fetchLeagues().1.first, .football)
    }
    
    func testDeleteLeague() {
        XCTAssertEqual(coreDataService.fetchLeagues().0.count, 0)
        let league = LeagueModel(leagueKey: 1, leagueName: "Test", countryKey: nil, countryName: nil, leagueLogo: nil, countryLogo: nil, leagueYear: nil)
        coreDataService.addLeague(league: league, sport: .basketball)
        XCTAssertEqual(coreDataService.fetchLeagues().0.count, 1)
        coreDataService.deleteLeague(leagueKey: 1, sport: .basketball)
        XCTAssertEqual(coreDataService.fetchLeagues().0.count, 0)
    }
    
    func testFavoriteLeague() {
        XCTAssertEqual(coreDataService.fetchLeagues().0.count, 0)
        let league = LeagueModel(leagueKey: 1, leagueName: "Test", countryKey: nil, countryName: nil, leagueLogo: nil, countryLogo: nil, leagueYear: nil)
        coreDataService.addLeague(league: league, sport: .cricket)
        XCTAssertTrue(coreDataService.checkFav(leagueKey: 1, sport: .cricket))
        XCTAssertFalse(coreDataService.checkFav(leagueKey: 1, sport: .tennis))
    }
    
}
