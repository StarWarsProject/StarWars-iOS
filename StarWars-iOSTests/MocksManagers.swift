//
//  ManagersMocks.swift
//  StarWars-iOSTests
//
//  Created by Alvaro Choque on 8/12/22.
//

import CoreData
@testable import StarWars_iOS
import XCTest

// Core Data Manager
class MockCoreDataManager: CoreDataManager {
    static func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!

        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)

        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            print("Adding in-memory persistent store failed")
        }

        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator

        return managedObjectContext
    }

    var context = setUpInMemoryManagedObjectContext()
    var forceSync = false
    override func saveContext() {
        print("mock saving context")
    }

    override func getContext() -> NSManagedObjectContext {
        return context
    }

    // swiftlint:disable force_cast
    // swiftlint:disable function_body_length
    // swiftlint:disable cyclomatic_complexity
    override func getData<T>(entity: StarWars_iOS.CoreDataEntities) -> [T] where T: NSManagedObject {
        switch T.self {
        case is Character.Type:
            let entities: [T] = TestResources.characterResponseList.map { char in
                return char.toEntity(context: context) as! T
            }
            return entities
        case is Planet.Type:
            let entities: [T] = TestResources.planetResponseList.map { planet in
                return planet.toEntity(context: context) as! T
            }
            return entities
        case is Specie.Type:
            let entities: [T] = TestResources.specieResponseList.map { specie in
                return specie.toEntity(context: context) as! T
            }
            return entities
        case is Starship.Type:
            let entities: [T] = TestResources.starshipResponseList.map { ship in
                return ship.toEntity(context: context) as! T
            }
            return entities
        case is Vehicle.Type:
            let entities: [T] = TestResources.vehiclesResponseList.map { vehicle in
                return vehicle.toEntity(context: context) as! T
            }
            return entities
        default:
            return []
        }
    }

    override func deleteAll() -> Bool {
        return true
    }

    override func deleteAllObjectsByEntity(entity: StarWars_iOS.CoreDataEntities) -> Bool {
        true
    }

    override func getEntityBy<T>(id: String, entity: StarWars_iOS.CoreDataEntities) -> T? where T: NSManagedObject {
        if T.Type.self == Movie.Type.self {
            let entity = TestResources.filmsResponseList.first?.toEntity(context: context)
            print("Movie")
            return entity as? T
        } else if T.Type.self == Character.Type.self {
            print("Character")
            if id == "3", forceSync {
                return nil
            }
            let entities = TestResources.characterResponseList.map({return $0.toEntity(context: context)})
            let entity = entities.first(where: {$0.id == Int16(id)})
            return entity as? T
        } else if T.Type.self == Planet.Type.self {
            print("Planet")
            if id == "3", forceSync {
                return nil
            }
            let entities = TestResources.planetResponseList.map({return $0.toEntity(context: context)})
            let entity = entities.first(where: {$0.id == Int16(id)})
            return entity as? T
        } else if T.Type.self == Specie.Type.self {
            print("Specie")
            if id == "3", forceSync {
                return nil
            }
            let entities = TestResources.specieResponseList.map({return $0.toEntity(context: context)})
            let entity = entities.first(where: {$0.id == Int16(id)})
            return entity as? T
        } else if T.Type.self == Starship.Type.self {
            print("Starship")
            if id == "3", forceSync {
                return nil
            }
            let entities = TestResources.starshipResponseList.map({return $0.toEntity(context: context)})
            let entity = entities.first(where: {$0.id == Int16(id)})
            return entity as? T
        } else if T.Type.self == Vehicle.Type.self {
            print("Vehicle")
            if id == "3", forceSync {
                return nil
            }
            let entities = TestResources.vehiclesResponseList.map({return $0.toEntity(context: context)})
            let entity = entities.first(where: {$0.id == Int16(id)})
            return entity as? T
        } else {
            print("default")
            return nil
        }
    }
}

class MockNetworkManager: NetworkManagerProtocol {
    var setWithError = false
    func getAsyncAwait<T: Decodable>(url: String) async throws -> (Result<T, Error>) {
        guard let data = FileReader.readFrom(url: url, as: T.self, withError: setWithError) else {
            return .failure(NSError())
        }
        return .success(data)
    }
}