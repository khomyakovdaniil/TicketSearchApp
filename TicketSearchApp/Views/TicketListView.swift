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
        ZStack {
            VStack {
                LocationsView(departureCity: model.departureCity, arrivalCity: model.arrivalCity, flightDate: model.flightDate) {
                    dismiss()
                }
                .padding(.horizontal)
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(model.tickets ?? [], id: \.self.id) { ticket in
                            TicketFullInfoView(data: ticket)
                        }
                    }
                }
                .padding()
                Spacer()
            }
            VStack {
                Spacer()
                HStack {
                    Image(systemName: "slider.horizontal.3")
                        .frame(width: 16, height: 16)
                    Text(Constants.TicketListView.filter)
                        .font(.system(size: 14))
                    Image(systemName: "chart.bar.xaxis")
                        .frame(width: 16, height: 16)
                    Text(Constants.TicketListView.priceChart)
                        .font(.system(size: 14))
                }
                .frame(width: 203, height: 37)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(hex: "#2261BC"))
                }
                .padding(.bottom, 32)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear() {
            model.getData()
        }
    }
}

fileprivate struct LocationsView: View {
    
    let departureCity: String
    let arrivalCity: String
    let flightDate: Date
    
    let backButtonAction: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "arrow.left")
                .frame(width: 24, height: 24)
                .foregroundColor(.blue)
                .onTapGesture {
                    backButtonAction()
                }
            VStack(alignment: .leading) {
                Text(departureCity + "-" + arrivalCity)
                    .font(.custom("SFProDisplay-Bold", size: 16))
                Text(flightDate.formattedDate() + ", 1 пассажир")
                    .font(.custom("SFProDisplay-Regular", size: 14))
                    .foregroundColor(Color(hex: "#9F9F9F"))
            }
            Spacer()
        }
        .padding()
        .background {
            Rectangle()
                .fill(Color(hex: "#242529"))
                .shadow(radius: 2, y: 2)
        }
    }
    
}

fileprivate struct TicketFullInfoView: View {
    
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
                    Text(price.priceFormatted() + " ₽")
                        .font(.custom("SFProDisplay-Bold", size: 22))
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
                            .font(.custom("SFProDisplay-LightItalic", size: 14))
                        Text(departureAirport)
                            .font(.custom("SFProDisplay-LightItalic", size: 14))
                    }
                    VStack {
                        Text("—")
                            .font(.custom("SFProDisplay-LightItalic", size: 14))
                        Spacer()
                    }
                    VStack {
                        Text(arrivalTime)
                            .font(.custom("SFProDisplay-LightItalic", size: 14))
                        Text(arrivalAirport)
                            .font(.custom("SFProDisplay-LightItalic", size: 14))
                    }
                    VStack {
                        HStack(spacing: 0) {
                            Text(flightDuration.toHours() + Constants.TicketListView.time)
                                .font(.custom("SFProDisplay-LightItalic", size: 14))
                            if !hasTransfer {
                                Text(Constants.TicketListView.direct)
                                    .font(.custom("SFProDisplay-LightItalic", size: 14))
                            }
                        }
                        Spacer()
                    }
                    .padding(.leading, 8)
                    Spacer()
                }
            }
            .padding(.leading)
            .padding(.vertical)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(hex: "#3E3F43"))
                    .shadow(radius: 2, y: 2)
            }
            .padding(.vertical, 8)
            if let badge {
                VStack {
                    Text(badge)
                        .font(.custom("SFProDisplay-LightItalic", size: 14))
                        .frame(height: 21)
                        .padding(.horizontal, 8)
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(hex: "#2261BC"))
                        }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    TicketListView(model: TicketListViewModel(coordinator: Coordinator()))
        .preferredColorScheme(.dark)
}
