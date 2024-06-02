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
    
    var coordinator: Coordinator
    
    @Published var data: HomeViewData?
    @Published var offers: [HomeViewData.Offer]?
    
    let strings = Constants.HomeView()
    let fontName = Constants.fontName
    
    @Published var departureCity: String = "Минск"
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
