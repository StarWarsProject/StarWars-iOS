//
//  EntitiesSearchResult.swift
//  StarWars-iOS
//
//  Created by Yawar Valeriano on 4/12/22.
//

struct EntitiesSearchResult<T> {
    let entities: [T]
    let missingIds: [String]
}
