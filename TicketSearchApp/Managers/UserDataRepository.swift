//
//  UserDataRepository.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 04.06.2024.
//

import Foundation
import SwiftUI

final class UserDataRepository {
    
    static let shared = UserDataRepository()
    
    @AppStorage("Departure city")
    var currentDepartureCity = ""
    var currentArrivalCity = ""
    var currentFlightDate = Date()
    var currentReturnDate: Date? = nil
    
}
