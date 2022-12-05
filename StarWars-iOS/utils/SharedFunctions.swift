//
//  SharedFunctions.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 28/11/22.
//

import Foundation
import UIKit

struct SharedFunctions {
    static func getImageForMovie(_ movieTitle: String) -> UIImage? {
        switch movieTitle {
        case "A New Hope":
            return UIImage(named: StringConstants.newHope)
        case "The Empire Strikes Back":
            return UIImage(named: StringConstants.empireBack)
        case "Return of the Jedi":
            return UIImage(named: StringConstants.returnJedi)
        case "The Phantom Menace":
            return UIImage(named: StringConstants.phantomMenace)
        case "Attack of the Clones":
            return UIImage(named: StringConstants.attackClones)
        case "Revenge of the Sith":
            return UIImage(named: StringConstants.revengeSith)
        default:
            return nil
        }
    }

    static func getDateFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: date)
    }
}
