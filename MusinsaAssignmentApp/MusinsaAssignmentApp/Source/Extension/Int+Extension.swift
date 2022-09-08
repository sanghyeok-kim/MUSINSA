//
//  Extension+Int.swift
//  MusinsaAssignmentApp
//
//  Created by 김상혁 on 2022/08/21.
//

import Foundation

extension Int {
    func toFormattedWonString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedWonString = numberFormatter.string(from: NSNumber(value: self))
        return "\(formattedWonString ?? "")원"
    }
}
