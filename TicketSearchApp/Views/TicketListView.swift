//
//  TicketListView.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 01.06.2024.
//

import SwiftUI

struct TicketListView: View {
    
    // MARK: - ViewModel
    @StateObject var model: TicketListViewModel
    
    // MARK: - dismissal action
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            NavigationView() {
                dismiss()
            }
            .padding(.bottom)
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(model.tickets ?? [], id: \.self.id) { ticket in
                        TicketFullInfoView(data: ticket)
                    }
                }
            }
            Spacer()
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear() {
            model.getData()
        }
    }
}

struct NavigationView: View {
    
    let backButtonAction: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "arrow.left")
                .frame(width: 24, height: 24)
                .foregroundColor(.blue)
                .onTapGesture {
                    backButtonAction()
                }
            VStack {
                Text("Москва-Сочи")
                Text("23 февраля, 1 пассажир")
                // TODO: replace with data from model
            }
        }
        .padding()
        .background {
            Rectangle()
                .fill(Color(hex: "#242529"))
                .shadow(radius: 2, y: 2)
        }
    }
    
}

struct TicketFullInfoView: View {
    
    private let badge: String?
    private let price: Int
    private let departureTime: String
    private let departureAirport: String
    private let arrivalTime: String
    private let arrivalAirport: String
    private let hasTransfer: Bool
    private let flightDuration: TimeInterval
    
    init(data: TicketListViewData.Ticket) {
        badge = data.badge
        price = data.price.value
        departureTime = data.departure.date.toDate().formattedTime()
        departureAirport = data.departure.airport
        arrivalTime = data.arrival.date.toDate().formattedTime()
        arrivalAirport = data.arrival.airport
        hasTransfer = data.hasTransfer
        flightDuration = data.arrival.date.toDate().timeIntervalSince(data.departure.date.toDate())
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                HStack {
                    Text("\(price)")
                    Spacer()
                }
                .padding(4)
                HStack(spacing: 2) {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 24, height: 24)
                        .padding(4)
                    VStack {
                        Text(departureTime)
                            .font(.system(size: 14)) // TODO: replace font
                        Text(departureAirport)
                            .font(.system(size: 14))
                    }
                    VStack {
                        Text("—")
                            .font(.system(size: 14))
                        Spacer()
                    }
                    VStack {
                        Text(arrivalTime)
                            .font(.system(size: 14))
                        Text(arrivalAirport)
                            .font(.system(size: 14))
                    }
                    VStack {
                        HStack(spacing: 0) {
                            Text(flightDuration.toHours() + "ч в пути")
                                .font(.system(size: 14))
                            if !hasTransfer {
                                Text(" / Без пересадок")
                                    .font(.system(size: 14))
                            }
                        }
                        Spacer()
                    }
                    .padding(.leading, 8)
                    Spacer()
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(hex: "#3E3F43"))
                    .shadow(radius: 2, y: 2)
            }
            .padding(8)
            if let badge {
                VStack {
                    Text(badge)
                        .font(.system(size: 14))
                        .frame(height: 21)
                        .padding(.horizontal, 8)
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(hex: "#2261BC"))
                        }
                    Spacer()
                }
                .padding(.leading, 8)
            }
        }
    }
}

#Preview {
    TicketListView(model: TicketListViewModel(coordinator: Coordinator()))
        .preferredColorScheme(.dark)
}
