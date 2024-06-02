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
    private let searchViewHeight = 90.0
    private let cellImageHeight = 132.0
    private let cellImageWidth = 132.0
    private let scrollViewHeight = 214.0
    private let cellImagePrompt = "HomeViewImage"
    
    // MARK: - dismissal action
    @Environment(\.dismiss) var dismiss
    
    // MARK: - View
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.left")
                    .frame(width: 24, height: 24)
                    .padding(.leading, 8)
                    .onTapGesture {
                        dismiss()
                    }
                VStack(alignment: .leading) {
                    HStack {
                        Text("Минск")
                            .foregroundColor(.gray)
                        Spacer()
                        Image(systemName: "arrow.up.arrow.down")
                            .frame(width: 24, height: 24)
                    }
                    Divider()
                        .background(Color(hex: "#9F9F9F"))
                    HStack {
                        Text("VJCRD")
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
            .padding()
            .padding(.top, 39)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    if let returnDate = model.returnDate {
                        returnDate.formattedToTextView()
                    } else {
                        HStack {
                            Image(systemName: "plus")
                                .frame(width: 16, height: 16)
                            Text("обратно")
                                .font(.custom(model.fontName, size: 14))
                        }
                        .padding(.horizontal)
                        .frame(height: 33)
                        .background {
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color(hex: "#2F3035"))
                        }
                    }
                    model.flightDate.formattedToTextView()
                        .padding(.horizontal)
                        .frame(height: 33)
                        .background {
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color(hex: "#2F3035"))
                        }
                    HStack {
                        Image(systemName: "person.fill")
                            .frame(width: 16, height: 16)
                        Text("1, эконом")
                            .font(.custom(model.fontName, size: 14))
                    }
                    .padding(.horizontal)
                    .frame(height: 33)
                    .background {
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color(hex: "#2F3035"))
                    }
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

#Preview {
    SearchView(model: SearchViewModel(coordinator: Coordinator()))
        .environmentObject(Coordinator())
}
