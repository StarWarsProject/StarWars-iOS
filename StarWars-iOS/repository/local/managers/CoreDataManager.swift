//
//  CoreDataManager.swift
//  StarWars-iOS
//
//  Created by Alvaro Choque on 23/11/22.
//

import Foundation
import CoreData

enum CoreDataEntities: String {
    case Movie
    case Character
    case Planet
    case Specie
    case Starship
    case Vehicle
}

protocol CoreDataManagerProtocol {
    func saveContext ()
    func getContext() -> NSManagedObjectContext
    func getData<T: NSManagedObject>(entity: CoreDataEntities) -> [T]
    func deleteAll() -> Bool
    func deleteAllObjectsByEntity(entity: CoreDataEntities) -> Bool
    func getEntityBy<T: NSManagedObject>(id: String, entity: CoreDataEntities) -> T?
    func getEntitiesFromIDArray<T: NSManagedObject>(_ ids: [String], entity: CoreDataEntities) -> EntitiesSearchResult<T>
}

class CoreDataManager: CoreDataManagerProtocol {
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

    @discardableResult
    func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func getData<T: NSManagedObject>(entity: CoreDataEntities) -> [T] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<T>(entityName: entity.rawValue)
        do {
            let dbWEntries = try context.fetch(fetchRequest)
            return dbWEntries
        } catch let error {
            print(error)
        }
        return []
    }

    @discardableResult
    func deleteAll() -> Bool {
        let context = self.getContext()
        let deleteMovies = NSBatchDeleteRequest(fetchRequest: Movie.fetchRequest())
        do {
            try context.execute(deleteMovies)
            return true
        } catch {
            print("cant clean coredata")
            return false
        }
    }

    @discardableResult
    func deleteAllObjectsByEntity(entity: CoreDataEntities) -> Bool {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity.rawValue)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try self.getContext().execute(deleteRequest)
            return true
        } catch let error as NSError {
            print("cant clean coredata for this entity: \(error.localizedDescription)")
            return false
        }
    }

    @discardableResult
    func deleteEntityObjectByKeyValue(entity: CoreDataEntities, key: String, value: Any) -> Bool {
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
        if  let sValue = value as? String {
            let predicate = NSPredicate(format: "\(key) == %@", sValue)
            fetchRequest.predicate = predicate
        } else if let iValue = value as? Int64 {
            let predicate = NSPredicate(format: "\(key) == %d", iValue)
            fetchRequest.predicate = predicate
        }
        do {
            let result = try context.fetch(fetchRequest)
            if !result.isEmpty {
                if let managedObject = result[0] as? NSManagedObject {
                    context.delete(managedObject)
                    do {
                        self.saveContext()
                        return true
                    }
                }
            }
            return false
        } catch let error {
            print(error.localizedDescription)
        }
        return false
    }

    func getEntityBy<T: NSManagedObject>(id: String, entity: CoreDataEntities) -> T? {
        guard let entityIDNumber = Int64(id) else { return nil }
        let context = getContext()
        let request = NSFetchRequest<T>(entityName: entity.rawValue)
        request.predicate = NSPredicate(format: "id == %ld", entityIDNumber)
        do {
            return try context.fetch(request).first
        } catch {
            print(error)
            return nil
        }
    }

    func getEntitiesFromIDArray<T: NSManagedObject>(_ ids: [String], entity: CoreDataEntities) -> EntitiesSearchResult<T> {
        var foundEntites = [T]()
        var notFoundIds = [String]()
        ids.forEach { id in
            let entity: T? = getEntityBy(id: id, entity: entity)
            if let safeEntity = entity {
                foundEntites.append(safeEntity)
            } else {
                notFoundIds.append(id)
            }
        }
        return EntitiesSearchResult(entities: foundEntites, missingIds: notFoundIds)
    }
}
