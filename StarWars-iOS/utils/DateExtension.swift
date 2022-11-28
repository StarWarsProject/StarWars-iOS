//
//  DateConverter.swift
//  StarWars-iOS
//
//  Created by Yawar Valeriano on 25/11/22.
//

import Foundation

extension Date {
    func getLocalString() -> String {
        let formatter = DateFormatter()
        let langStr = Locale.current.languageCode
        if langStr == "es" {
            formatter.locale = Locale(identifier: "es_ES")
            formatter.setLocalizedDateFormatFromTemplate("dd-MMMM-yyyy")
        } else {
            formatter.locale = Locale(identifier: "en_us")
            formatter.setLocalizedDateFormatFromTemplate("MMMM dd, yyyy")
        }
        return formatter.string(from: self)
    }
}
