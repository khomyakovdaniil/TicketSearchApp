//
//  HomeViewModel.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 01.06.2024.
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    
    @EnvironmentObject var coordinator: Coordinator
    
    @Published var data: HomeViewData?
    @Published var offers: [HomeViewData.Offer]?
    
    let strings = Constants.HomeView()
    let fontName = Constants.fontName
    
    @State var departureCity: String = "Минск"
    @State var arrivalCity: String = ""
    
    init() {
        bind()
    }
    
    private func bind() {
        $data.map({ $0?.offers }).assign(to: &$offers)
    }
    
    func getData() {
        NetworkManager.fetchHomeViewData()
            .optionalize()
            .replaceError(with: nil)
            .assign(to: &$data)
    }
    
    func userInititatedArrivalCityTextEdit() {
        coordinator.showSearchSheet()
    }
}
