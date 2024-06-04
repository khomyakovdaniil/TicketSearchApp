//
//  SearchViewModel.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 01.06.2024.
//

import Foundation
import SwiftUI

final class SearchViewModel: ObservableObject {

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        bind()
    }
    
    let coordinator: Coordinator
    let userDataRepository = UserDataRepository.shared
    
    @Published var data: SearchViewData?
    @Published var offers: [SearchViewData.TicketOffer]?
    
    let strings = Constants.SearchView.self
    let fontName = Constants.fontName
    
    @AppStorage("Departure city")
    var departureCity: String = "Минск" {
        willSet {
           DispatchQueue.main.async {
              self.objectWillChange.send()
           }
        }
    }
    
    @Published var arrivalCity: String = UserDataRepository.shared.currentArrivalCity
    @Published var flightDate: Date = UserDataRepository.shared.currentFlightDate
    @Published var returnDate: Date?
    
    private func bind() {
        $data.map({ $0?.ticketsOffers }).assign(to: &$offers)
    }
    
    func getData() {
        NetworkManager.fetchSearchViewData()
            .optionalize()
            .replaceError(with: nil)
            .assign(to: &$data)
    }
    
    @MainActor
    func userTappedShowAllTickets() {
        userDataRepository.currentArrivalCity = arrivalCity
        userDataRepository.currentFlightDate = flightDate
        coordinator.showTicketListView()
    }
}
