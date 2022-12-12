//
//  MovieDetailViewModelTests.swift
//  StarWars-iOSTests
//
//  Created by Alvaro Choque on 8/12/22.
//

import Foundation
import CoreData
import XCTest
@testable import StarWars_iOS

// swiftlint:disable force_cast
class MovieDetailTests: XCTestCase {
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
    var movieDetailViewModel: MovieDetailViewModel?
    let detailManager = DetaiManager()
    let detailManagerLocal = DetailManagerLocal()
    let detailNetworkManager = DetailManagerNetwork()
    override func setUp() {
        let ent = Movie(context: context)
        ent.id = 1
        detailNetworkManager.networkManager = MockNetworkManager()
        detailManager.networkManager = detailNetworkManager
        detailManager.coreDataManager = MockCoreDataManager()
        detailManager.isConnectedToInternet = true
        detailManagerLocal.coreDataManager = MockCoreDataManager()
        detailManager.localDataManager = detailManagerLocal
        movieDetailViewModel = MovieDetailViewModel(movie: ent, manager: detailManager)
    }

    func testGetCharacters() async {
        await movieDetailViewModel?.getCharacters()
        XCTAssertTrue(movieDetailViewModel?.charactersList.count == 3)
    }

    func testGetPlanets() async {
        await movieDetailViewModel?.getPlanets()
        XCTAssert(movieDetailViewModel?.planetsList.count == 3)
    }

    func testGetSpecies() async {
        await movieDetailViewModel?.getSpecies()
        XCTAssert(movieDetailViewModel?.speciesList.count == 3)
    }

    func testGetStarships() async {
        await movieDetailViewModel?.getStarships()
        XCTAssert(movieDetailViewModel?.shipsList.count == 3)
    }

    func testGetVehicles() async {
        await movieDetailViewModel?.getVehicles()
        XCTAssert(movieDetailViewModel?.vehiclesList.count == 3)
    }

    func testGetCharactersWhenMissing() async {
        ((movieDetailViewModel?.manager as! DetaiManager).coreDataManager as! MockCoreDataManager).forceSync = true
        await movieDetailViewModel?.getCharacters()
        XCTAssertTrue(movieDetailViewModel?.charactersList.count == 3)
    }

    func testGetPlanetsWhenMissing() async {
        ((movieDetailViewModel?.manager as! DetaiManager).coreDataManager as! MockCoreDataManager).forceSync = true
        await movieDetailViewModel?.getPlanets()
        XCTAssert(movieDetailViewModel?.planetsList.count == 3)
    }

    func testGetSpeciesWhenMissing() async {
        ((movieDetailViewModel?.manager as! DetaiManager).coreDataManager as! MockCoreDataManager).forceSync = true
        await movieDetailViewModel?.getSpecies()
        XCTAssert(movieDetailViewModel?.speciesList.count == 3)
    }

    func testGetStarshipsWhenMissing() async {
        ((movieDetailViewModel?.manager as! DetaiManager).coreDataManager as! MockCoreDataManager).forceSync = true
        await movieDetailViewModel?.getStarships()
        XCTAssert(movieDetailViewModel?.shipsList.count == 3)
    }

    func testGetVehiclesWhenMissing() async {
        ((movieDetailViewModel?.manager as! DetaiManager).coreDataManager as! MockCoreDataManager).forceSync = true
        await movieDetailViewModel?.getVehicles()
        XCTAssert(movieDetailViewModel?.vehiclesList.count == 3)
    }

    func testGetCharactersWithRequestFailed() async {
        ((movieDetailViewModel?.manager as! DetaiManager).coreDataManager as! MockCoreDataManager).forceSync = true
        (((movieDetailViewModel?.manager as! DetaiManager).networkManager as! DetailManagerNetwork).networkManager as! MockNetworkManager)
            .setWithError = true
        await movieDetailViewModel?.getCharacters()
        XCTAssertTrue(movieDetailViewModel?.charactersList.isEmpty == true)
    }

    func testGetPlanetsWithRequestFailed() async {
        ((movieDetailViewModel?.manager as! DetaiManager).coreDataManager as! MockCoreDataManager).forceSync = true
        (((movieDetailViewModel?.manager as! DetaiManager).networkManager as! DetailManagerNetwork).networkManager as! MockNetworkManager)
            .setWithError = true
        await movieDetailViewModel?.getPlanets()
        XCTAssert(movieDetailViewModel?.planetsList.isEmpty == true)
    }

    func testGetSpeciesWithRequestFailed() async {
        ((movieDetailViewModel?.manager as! DetaiManager).coreDataManager as! MockCoreDataManager).forceSync = true
        (((movieDetailViewModel?.manager as! DetaiManager).networkManager as! DetailManagerNetwork).networkManager as! MockNetworkManager)
            .setWithError = true
        await movieDetailViewModel?.getSpecies()
        XCTAssert(movieDetailViewModel?.speciesList.isEmpty == true)
    }

    func testGetStarshipsWithRequestFailed() async {
        ((movieDetailViewModel?.manager as! DetaiManager).coreDataManager as! MockCoreDataManager).forceSync = true
        (((movieDetailViewModel?.manager as! DetaiManager).networkManager as! DetailManagerNetwork).networkManager as! MockNetworkManager)
            .setWithError = true
        await movieDetailViewModel?.getStarships()
        XCTAssert(movieDetailViewModel?.shipsList.isEmpty == true)
    }

    func testGetVehiclesWithRequestFailed() async {
        ((movieDetailViewModel?.manager as! DetaiManager).coreDataManager as! MockCoreDataManager).forceSync = true
        (((movieDetailViewModel?.manager as! DetaiManager).networkManager as! DetailManagerNetwork).networkManager as! MockNetworkManager)
            .setWithError = true
        await movieDetailViewModel?.getVehicles()
        XCTAssert(movieDetailViewModel?.vehiclesList.isEmpty == true)
    }
}
