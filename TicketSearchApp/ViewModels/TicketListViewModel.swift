//
//  TicketListViewModel.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 01.06.2024.
//

import Foundation

final class TicketListViewModel: ObservableObject {
   
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        bind()
    }
    
    var coordinator: Coordinator
    
    @Published var data: TicketListViewData? {
        didSet {
            print("Gotcha")
        }
    }
    @Published var tickets: [TicketListViewData.Ticket]? {
        didSet {
            print("Gotcha")
        }
    }
    
    let strings = Constants.SearchView()
    let fontName = Constants.fontName
    
    @Published var departureCity: String = "Минск"
    @Published var arrivalCity: String = ""
    @Published var flightDate: Date = Date()
    @Published var returnDate: Date?
    
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
