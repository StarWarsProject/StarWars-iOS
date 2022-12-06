//
//  TabProtocolResponse.swift
//  StarWars-iOS
//
//  Created by Yawar Valeriano on 6/12/22.
//

import CoreData

protocol ModelResponseProtocol {
    func toEntity(context: NSManagedObjectContext) -> NSManagedObject
}
