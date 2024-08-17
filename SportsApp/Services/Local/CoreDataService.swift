//
//  CoreDataService.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 12/08/2024.
//

import UIKit
import CoreData

protocol CoreDataServiceProtocol {
    func addLeague(league: LeagueModel, sport: Sport)
    func fetchLeagues() -> ([LeagueModel], [Sport])
    func deleteLeague(key: Int, sport: Sport)
    func checkFav(key: Int, sport: Sport) -> Bool
}

class CoreDataService: CoreDataServiceProtocol {
    static let shared = CoreDataService()
    let appDelegate: AppDelegate
    let managedContext: NSManagedObjectContext
    
    private init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    private func saveContext() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func addLeague(league: LeagueModel, sport: Sport) {
        let entity = NSEntityDescription.entity(forEntityName: "LeagueEntity", in: managedContext)
        let leagueObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        leagueObject.setValue(league.leagueKey, forKey: "leagueKey")
        leagueObject.setValue(league.leagueName, forKey: "leagueName")
        leagueObject.setValue(league.countryKey, forKey: "countryKey")
        leagueObject.setValue(league.countryName, forKey: "countryName")
        leagueObject.setValue(league.leagueLogo, forKey: "leagueLogo")
        leagueObject.setValue(league.countryLogo, forKey: "countryLogo")
        leagueObject.setValue(league.leagueYear, forKey: "leagueYear")
        leagueObject.setValue(sport.rawValue, forKey: "sport")
        saveContext()
    }
    
    func fetchLeagues() -> ([LeagueModel], [Sport]) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"LeagueEntity")
        
        var leagues = [LeagueModel]()
        var sports = [Sport]()
        do {
            let leagueObjects = try managedContext.fetch(fetchRequest)
            for leagueObject in leagueObjects {
                let league = LeagueModel(
                    leagueKey: leagueObject.value(forKey: "leagueKey") as! Int,
                    leagueName: leagueObject.value(forKey: "leagueName") as! String,
                    countryKey: leagueObject.value(forKey: "countryKey") as! Int?,
                    countryName: leagueObject.value(forKey: "countryName") as! String?,
                    leagueLogo: leagueObject.value(forKey: "leagueLogo") as! String?,
                    countryLogo: leagueObject.value(forKey: "countryLogo") as! String?,
                    leagueYear: leagueObject.value(forKey: "leagueYear") as! String?
                )
                let sportRawValue = leagueObject.value(forKey: "sport") as! String
                let sport = Sport(rawValue: sportRawValue) ?? .football
                leagues.append(league)
                sports.append(sport)
            }
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        return (leagues, sports)
    }
    
    func deleteLeague(key: Int, sport: Sport) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"LeagueEntity")
        let myPredicate = NSPredicate(format: "leagueKey == %d && sport == %@", key, sport.rawValue)
        fetchRequest.predicate = myPredicate
        do {
            let leagues = try managedContext.fetch(fetchRequest)
            if !leagues.isEmpty {
                managedContext.delete(leagues[0])
            }
            saveContext()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func checkFav(key: Int, sport: Sport) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"LeagueEntity")
        let myPredicate = NSPredicate(format: "leagueKey == %d && sport == %@", key, sport.rawValue)
        fetchRequest.predicate = myPredicate

        do {
            let leagueObjects = try managedContext.fetch(fetchRequest)
            return !leagueObjects.isEmpty
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        return false
    }
    
}
