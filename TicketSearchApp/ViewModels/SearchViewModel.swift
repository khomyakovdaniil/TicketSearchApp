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
    
    var coordinator: Coordinator
    
    @Published var data: SearchViewData? {
        didSet {
            print("gotcha")
        }
    }
    @Published var offers: [SearchViewData.TicketOffer]? {
        didSet {
            print("gotcha")
        }
    }
    
    let strings = Constants.SearchView()
    let fontName = Constants.fontName
    
    @AppStorage("Departure city")
    var departureCity: String = "Минск" {
        willSet {
           DispatchQueue.main.async {
              self.objectWillChange.send()
           }
        }
    }
    @Published var arrivalCity: String = "Москва"
    @Published var flightDate: Date = Date()
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
        coordinator.showTicketListView()
    }
}
