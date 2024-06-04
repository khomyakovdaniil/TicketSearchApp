//
//  TicketListViewModel.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 01.06.2024.
//

import Foundation
import SwiftUI

final class TicketListViewModel: ObservableObject {
   
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        bind()
    }
    
    let coordinator: Coordinator
    
    let userDataRepository = UserDataRepository.shared
    
    @Published var data: TicketListViewData?
    @Published var tickets: [TicketListViewData.Ticket]?
    
    let strings = Constants.SearchView()
    let fontName = Constants.fontName
    
    var departureCity: String = UserDataRepository.shared.currentDepartureCity
    var arrivalCity: String = UserDataRepository.shared.currentArrivalCity
    var flightDate: Date = UserDataRepository.shared.currentFlightDate
    
    private func bind() {
        $data.map({ $0?.tickets }).assign(to: &$tickets)
    }
    
    func getData() {
        NetworkManager.fetchTicketListViewData()
            .optionalize()
            .replaceError(with: nil)
            .assign(to: &$data)
    }
    
}
