//
//  CoreDataManager.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 23/11/22.
//

import Foundation
import CoreData

class CoreDataManager {
    static var shared = CoreDataManager()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "StarWars_iOS")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func getData<T: NSManagedObject>(entity: String) -> [T] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<T>(entityName: entity)
        do {
            let dbWEntries = try context.fetch(fetchRequest)
            return dbWEntries
        } catch let error {
            print(error)
        }
        return []
    }

}
