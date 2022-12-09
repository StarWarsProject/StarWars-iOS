//
//  TestResources.swift
//  StarWars-iOSTests
//
//  Created by Alvaro Choque on 8/12/22.
//

import Foundation
@testable import StarWars_iOS

class TestResources {
    static let filmsResponseList = [
        Film(title: "film1", episodeID: 1, openingCrawl: "oc1", director: "d1", producer: "p1",
             releaseDate: "r1", characters: ["/1/", "/2/", "/3/"], planets: ["/1/", "/2/", "/3/"],
             starships: ["/1/", "/2/", "/3/"], vehicles: ["/1/", "/2/", "/3/"], species: ["/1/", "/2/", "/3/"],
             created: "01-01-2022", edited: "01-01-2022", url: "films/1/"),
        Film(title: "film2", episodeID: 2, openingCrawl: "oc2", director: "d2", producer: "p2",
             releaseDate: "r2", characters: ["/1/", "/2/"], planets: ["/1/", "/2/"], starships: ["/1/", "/2/"],
             vehicles: ["/1/", "/2/"], species: ["/1/", "/2/"], created: "01-01-2022", edited: "01-01-2022", url: "films/2/"),
        Film(title: "film3", episodeID: 3, openingCrawl: "oc3", director: "d3", producer: "p3",
             releaseDate: "r3", characters: ["/1/"], planets: ["/1/"], starships: ["/1/"], vehicles: ["/1/"],
             species: ["/1/"], created: "01-01-2022", edited: "01-01-2022", url: "films/3/")
    ]

    static let characterResponseList = [
        CharacterResponse(name: "char1", height: "he1", mass: "ma1", hairColor: "ha1",
                          skinColor: "sk1", eyeColor: "ec1", birthYear: "by1", gender: "g1",
                          homeworld: "hw1", films: ["1", "2", "3"], species: ["1", "2", "3"],
                          vehicles: ["1", "2", "3"], starships: ["1", "2", "3"],
                          created: "01-01-2022", edited: "01-01-2022", url: "/people/1/"),
        CharacterResponse(name: "char2", height: "he2", mass: "ma2", hairColor: "ha2",
                          skinColor: "sk2", eyeColor: "ec2", birthYear: "by2", gender: "g2",
                          homeworld: "hw2", films: ["1", "2"], species: ["1", "2", "3"],
                          vehicles: ["1", "2", "3"], starships: ["1", "2", "3"],
                          created: "01-01-2022", edited: "01-01-2022", url: "/people/2/"),
        CharacterResponse(name: "char3", height: "he3", mass: "ma3", hairColor: "ha3",
                          skinColor: "sk3", eyeColor: "ec3", birthYear: "by3", gender: "g3",
                          homeworld: "hw3", films: ["1"], species: ["1", "2", "3"],
                          vehicles: ["1", "2", "3"], starships: ["1", "2", "3"],
                          created: "01-01-2022", edited: "01-01-2022", url: "/people/3/")
    ]

    static let planetResponseList = [
        PlanetResponse(name: "plan1", diameter: "d1", climate: "c1", gravity: "g1", terrain: "t1",
                       population: "p1", rotationPeriod: "rp1", orbitalPeriod: "op1", surfaceWater: "sw1",
                       created: "01-01-2022", edited: "01-01-2022", url: "/planets/1/"),
        PlanetResponse(name: "plan2", diameter: "d2", climate: "c2", gravity: "g2", terrain: "t2",
                       population: "p2", rotationPeriod: "rp2", orbitalPeriod: "op2", surfaceWater: "sw2",
                       created: "01-01-2022", edited: "01-01-2022", url: "/planets/2/"),
        PlanetResponse(name: "plan3", diameter: "d3", climate: "c3", gravity: "g3", terrain: "t3",
                       population: "p3", rotationPeriod: "rp3", orbitalPeriod: "op3", surfaceWater: "sw3",
                       created: "01-01-2022", edited: "01-01-2022", url: "/planets/3/")
    ]

    static let specieResponseList = [
        SpecieResponse(name: "specie1", classification: "c1", designation: "d1", language: "l1",
                       averageHeight: "ah1", skinColors: "sk1", hairColors: "hc1", eyeColors: "ec1",
                       averageLifespan: "al1", created: "01-01-2022", edited: "01-01-2022",
                       url: "/species/1/", homeworld: "hw1"),
        SpecieResponse(name: "specie2", classification: "c2", designation: "d2", language: "l2",
                       averageHeight: "ah2", skinColors: "sk2", hairColors: "hc2", eyeColors: "ec2",
                       averageLifespan: "al2", created: "01-01-2022", edited: "01-01-2022",
                       url: "/species/2/", homeworld: "hw2"),
        SpecieResponse(name: "specie3", classification: "c3", designation: "d3", language: "l3",
                       averageHeight: "ah3", skinColors: "sk3", hairColors: "hc3", eyeColors: "ec3",
                       averageLifespan: "al3", created: "01-01-2022", edited: "01-01-2022",
                       url: "/species/3/", homeworld: "hw3")
    ]

    static let starshipResponseList = [
        StarshipsResponse(name: "starship1", model: "m1", manufacturer: "mn1", costInCredits: "cic1",
                          length: "l1", maxAtmospheringSpeed: "mas1", crew: "c1", passengers: "p1",
                          cargoCapacity: "cc1", consumables: "c1", hyperdriveRating: "hr1", mglt: "m1",
                          starshipClass: "sc1", pilots: [], films: ["1"], created: "01-01-2022", edited: "01-01-2022",
                          url: "/starships/1/"),
        StarshipsResponse(name: "starship12", model: "m2", manufacturer: "mn2", costInCredits: "cic2",
                          length: "l2", maxAtmospheringSpeed: "mas2", crew: "c2", passengers: "p2",
                          cargoCapacity: "cc2", consumables: "c2", hyperdriveRating: "hr2", mglt: "m2",
                          starshipClass: "sc2", pilots: [], films: ["1"], created: "01-01-2022", edited: "01-01-2022",
                          url: "/starships/2/"),
        StarshipsResponse(name: "starship3", model: "m3", manufacturer: "mn3", costInCredits: "cic3",
                          length: "l3", maxAtmospheringSpeed: "mas3", crew: "c3", passengers: "p3",
                          cargoCapacity: "cc3", consumables: "c3", hyperdriveRating: "hr3", mglt: "m3",
                          starshipClass: "sc3", pilots: [], films: ["1"], created: "01-01-2022", edited: "01-01-2022",
                          url: "/starships/3/")
    ]

    static let vehiclesResponseList = [
        VehicleResponse(name: "vehicle1", model: "m1", manufacturer: "mn1", length: "l1", crew: "c1",
                        passengers: "p1", consumables: "c1", costInCredits: "cic1", maxAtmospheringSpeed: "mas1",
                        cargoCapacity: "cc1", vehicleClass: "vc1", created: "01-01-2022", edited: "01-01-2022",
                        url: "/vehicles/1/"),
        VehicleResponse(name: "vehicle2", model: "m2", manufacturer: "mn2", length: "l2", crew: "c2",
                        passengers: "p2", consumables: "c2", costInCredits: "cic2", maxAtmospheringSpeed: "mas2",
                        cargoCapacity: "cc2", vehicleClass: "vc2", created: "01-01-2022", edited: "01-01-2022",
                        url: "/vehicles/2/"),
        VehicleResponse(name: "vehicle3", model: "m3", manufacturer: "mn3", length: "l3", crew: "c3",
                        passengers: "p3", consumables: "c3", costInCredits: "cic3", maxAtmospheringSpeed: "mas3",
                        cargoCapacity: "cc3", vehicleClass: "vc3", created: "01-01-2022", edited: "01-01-2022",
                        url: "/vehicles/3/")
    ]
}
