//
//  HomeViewModel.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 01.06.2024.
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        bind()
    }
    
    let coordinator: Coordinator
    
    @Published var data: HomeViewData?
    @Published var offers: [HomeViewData.Offer]?
    
    let strings = Constants.HomeView.self
    let fontName = Constants.fontName
    
    @AppStorage("Departure city")
    var departureCity: String = "" {
        willSet {
           DispatchQueue.main.async {
              self.objectWillChange.send()
           }
        }
    }
    @Published var arrivalCity: String = ""
    
    private func bind() {
        $data.map({ $0?.offers }).assign(to: &$offers)
    }
    
    func getData() {
        NetworkManager.fetchHomeViewData()
            .optionalize()
            .replaceError(with: nil)
            .assign(to: &$data)
    }
    
    @MainActor 
    func userInititatedArrivalCityTextEdit() {
        coordinator.showSearchSheet()
    }
}
