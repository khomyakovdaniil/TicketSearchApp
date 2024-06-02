//
//  Double+Rounded.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 02.06.2024.
//

import Foundation

extension Double {
    func rounded(to nearest: Double) -> Double {
        let n = 1/nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }
}
