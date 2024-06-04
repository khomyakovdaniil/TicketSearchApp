//
//  SearchSheetViewModel.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 01.06.2024.
//

import Foundation
import SwiftUI

final class SearchSheetViewModel: ObservableObject {
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    var coordinator: Coordinator
    
    @AppStorage("Departure city")
    var departureCity: String = "Минск" {
        willSet {
           DispatchQueue.main.async {
              self.objectWillChange.send()
           }
        }
    }
    @Published var arrivalCity: String = ""
    
    struct ActionData {
        let imagename: String
        let text: String
        let action: @MainActor () -> Void
    }
    
    struct SuggestionData {
        let imagename: String
        let text: String
    }
    
    let strings = Constants.SearchSheet()
    let actionTitles = Constants.SearchSheet.ActionTitles()
    let suggestionCities = Constants.SearchSheet.SuggestionCities()
    let fontName = Constants.fontName
    
    
    lazy var actions: [ActionData] = [
        ActionData(imagename: "routeIcon", text: actionTitles.route, action: { [weak self] in self?.coordinator.showPlugSheet() }),
        ActionData(imagename: "globeIcon", text: actionTitles.anywhere, action: { [weak self] in self?.arrivalCity = self?.actionTitles.anywhere ?? "" }),
        ActionData(imagename: "calendarIcon", text: actionTitles.holiday, action: { [weak self] in self?.coordinator.showPlugSheet() }),
        ActionData(imagename: "fireIcon", text: actionTitles.hot, action: { [weak self] in self?.coordinator.showPlugSheet() })
    ]
    
    lazy var suggestions: [SuggestionData] = [
        SuggestionData(imagename: "stambulImage", text: suggestionCities.stambul),
        SuggestionData(imagename: "sochiImage", text: suggestionCities.sochi),
        SuggestionData(imagename: "phucketImage", text: suggestionCities.phucket)
    ]
    
    @MainActor 
    func userEnteredArrivalCity() {
        coordinator.arrivalCity = arrivalCity
        coordinator.showSearchView()
    }
    
}
