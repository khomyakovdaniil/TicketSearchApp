//
//  SearchView.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 01.06.2024.
//

import SwiftUI

struct SearchView: View {
    
    // MARK: - ViewModel
    @StateObject var model: SearchViewModel
    
    // MARK: - Private constants
    private let titleFontSize = 22.0
    private let titleViewWidth = 172.0
    private let titleViewHeight = 52.0
    private let subtitleFontSize = 26.0
    private let cellImageHeight = 132.0
    private let cellImageWidth = 132.0
    private let scrollViewHeight = 214.0
    private let cellImagePrompt = "HomeViewImage"
    
    // MARK: - Dismissal action
    @Environment(\.dismiss) var dismiss
    
    // MARK: - View
    var body: some View {
        VStack {
            LocationsView(arrivalCity: $model.arrivalCity,
                          departureCity: $model.departureCity) {
                dismiss()
            }
            .padding()
            .padding(.top, 39)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ReturnDateView(returnDate: $model.returnDate)
                    FlightDateView(flightDate: $model.flightDate)
                    PassengersView()
                    HStack {
                        Image(systemName: "slider.horizontal.3")
                            .frame(width: 16, height: 16)
                        Text("фильтры")
                            .font(.custom(model.fontName, size: 14))
                    }
                    .padding(.horizontal)
                    .frame(height: 33)
                    .background {
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color(hex: "#2F3035"))
                    }
                }
            }
            .padding(.leading)
            LazyVStack {
                ForEach(model.offers ?? [], id: \.self.id) {
                    ticketOffer in
                    //                    List(model.offers ?? [], id: \.self.id) { ticketOffer in
                    HStack {
                        Image(systemName: "slider.horizontal.3") // TODO: replace with colored circles
                        VStack(alignment: .leading) {
                            HStack {
                                Text(ticketOffer.title)
                                Spacer()
                                Text("\(ticketOffer.price.value)")
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(ticketOffer.timeRange, id: \.self) { time in
                                        Text(time)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            Button() {
                model.userTappedShowAllTickets()
            } label: {
                Text("Посмотреть все билеты")
            }
            Spacer()
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear() {
            model.getData()
        }
    }
}

fileprivate struct LocationsView: View {
    
    @Binding var arrivalCity: String
    @Binding var departureCity: String
    
    private let searchViewHeight = 90.0
    
    let backButtonAction: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "arrow.left")
                .frame(width: 24, height: 24)
                .padding(.leading, 8)
                .onTapGesture {
                    backButtonAction()
                }
            VStack(alignment: .leading) {
                HStack {
                    Text(departureCity)
                        .foregroundColor(.gray)
                    Spacer()
                    Image(systemName: "arrow.up.arrow.down")
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                            let tmp = arrivalCity
                            arrivalCity = departureCity
                            departureCity = tmp
                        }
                }
                Divider()
                    .background(Color(hex: "#9F9F9F"))
                HStack {
                    Text(arrivalCity)
                        .foregroundColor(.gray)
                    Spacer()
                    Image(systemName: "xmark")
                        .frame(width: 24, height: 24)
                }
            }
        }
        .padding(.trailing)
        .frame(height: searchViewHeight) // TODO: handle size
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#2F3035"))
                .shadow(radius: 2, y: 2)
        }
    }
}

fileprivate struct ReturnDateView: View {
    
    @Binding var returnDate: Date?
    
    @State private var returnDateUnwrapped: Date = Date()
    
    var body: some View {
        if let returnDateUnwr = returnDate {
            HStack {
                Image(systemName: "xmark")
                    .frame(maxHeight: 33)
                    .onTapGesture {
                        returnDate = nil
                    }
                returnDateUnwr.formattedToTextView()
                    .overlay {
                        VStack {
                            DatePicker(
                                "",
                                selection: $returnDateUnwrapped,
                                displayedComponents: [.date]
                            )
                            .onChange(of: returnDateUnwrapped, perform: { value in
                                returnDate = value
                            })
                        }
                        .blendMode(.destinationOver)
                    }
            }
            .padding(.horizontal)
            .frame(height: 33)
            .background {
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color(hex: "#2F3035"))
            }
        } else {
            HStack {
                Image(systemName: "plus")
                    .frame(width: 16, height: 16)
                Text("обратно")
                    .font(.system(size: 14)) // TODO: replace font
            }
            .padding(.horizontal)
            .frame(height: 33)
            .background {
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color(hex: "#2F3035"))
            }
            .overlay{
               DatePicker(
                   "",
                   selection: $returnDateUnwrapped,
                   displayedComponents: [.date]
               )
                .blendMode(.destinationOver)
                .onChange(of: returnDateUnwrapped, perform: { value in
                    returnDate = value
                 })
            }
        }
    }
}

fileprivate struct FlightDateView: View {
    
    // MARK: - State variables
    
    @State private var isUpdatingDate = false
    
    @Binding var flightDate: Date
    
    var body: some View {
        flightDate.formattedToTextView()
            .padding(.horizontal)
            .frame(height: 33)
            .background {
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color(hex: "#2F3035"))
            }
            .overlay{
               DatePicker(
                   "",
                   selection: $flightDate,
                   displayedComponents: [.date]
               )
                .blendMode(.destinationOver)
                .onChange(of: flightDate, perform: { value in
                    flightDate = value
                 })
            }
    }
}

fileprivate struct PassengersView: View {
    
    var body: some View {
        HStack {
            Image(systemName: "person.fill")
                .frame(width: 16, height: 16)
            Text("1, эконом")
                .font(.system(size: 14)) // TODO: replace font
        }
        .padding(.horizontal)
        .frame(height: 33)
        .background {
            RoundedRectangle(cornerRadius: 50)
                .fill(Color(hex: "#2F3035"))
        }
    }
}

#Preview {
    SearchView(model: SearchViewModel(coordinator: Coordinator()))
        .preferredColorScheme(.dark)
}
