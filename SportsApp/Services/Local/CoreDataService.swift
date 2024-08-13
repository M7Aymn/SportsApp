//
//  CoreDataService.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 12/08/2024.
//

import UIKit
import CoreData

protocol CoreDataServiceProtocol {
    func addLeague(league: LeagueModel)
    func fetchLeagues() -> [LeagueModel]
    func deleteLeague(key: Int)
    func checkFav(key: Int) -> Bool
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
            print(error)
        }
    }
    
    func addLeague(league: LeagueModel) {
        let entity = NSEntityDescription.entity(forEntityName: "LeagueEntity", in: managedContext)
        let leagueObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        leagueObject.setValue(league.leagueKey, forKey: "leagueKey")
        leagueObject.setValue(league.leagueName, forKey: "leagueName")
        leagueObject.setValue(league.countryKey, forKey: "countryKey")
        leagueObject.setValue(league.countryName, forKey: "countryName")
        leagueObject.setValue(league.leagueLogo, forKey: "leagueLogo")
        leagueObject.setValue(league.countryLogo, forKey: "countryLogo")
        saveContext()
    }
    
    func fetchLeagues() -> [LeagueModel] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"LeagueEntity")
        
        var leagues = [LeagueModel]()
        do {
            let leagueObjects = try managedContext.fetch(fetchRequest)
            for leagueObject in leagueObjects {
                let league = LeagueModel(
                    leagueKey: leagueObject.value(forKey: "leagueKey") as! Int,
                    leagueName: leagueObject.value(forKey: "leagueName") as! String,
                    countryKey: leagueObject.value(forKey: "countryKey") as! Int,
                    countryName: leagueObject.value(forKey: "countryName") as! String,
                    leagueLogo: leagueObject.value(forKey: "leagueLogo") as! String?,
                    countryLogo: leagueObject.value(forKey: "countryLogo") as! String?
                )
                leagues.append(league)
            }
        } catch let error as NSError{
            print(error)
        }
        return leagues
    }
    
    func deleteLeague(key: Int) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"LeagueEntity")
        let myPredicate = NSPredicate(format: "leagueKey == %d", key)
        fetchRequest.predicate = myPredicate
        do {
            let leagues = try managedContext.fetch(fetchRequest)
            if !leagues.isEmpty {
                managedContext.delete(leagues[0])
            }
            saveContext()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func checkFav(key: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"LeagueEntity")
        let myPredicate = NSPredicate(format: "leagueKey == %d", key)
        fetchRequest.predicate = myPredicate

        do {
            let leagueObjects = try managedContext.fetch(fetchRequest)
            return !leagueObjects.isEmpty
        } catch let error as NSError{
            print(error)
        }
        return false
    }
    
}
