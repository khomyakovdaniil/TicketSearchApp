//
//  HomeView.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 01.06.2024.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - ViewModel
    @StateObject var model: HomeViewModel
    
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
    
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text(model.strings.title)
                    .font(.custom(model.fontName, size: titleFontSize))
                    .multilineTextAlignment(.center)
                    .frame(width: titleViewWidth, height: titleViewHeight)
                    .padding()
                Spacer()
            }
            LocationsView(departureCity: $model.departureCity, departureCityPrompt: model.strings.departureCityPrompt, arrivalCityPrompt: model.strings.arrivalCityPrompt, searchViewHeight: searchViewHeight) {
                model.userInititatedArrivalCityTextEdit()
            }
            .padding()
            Text(model.strings.subTitle)
                .font(.custom(model.fontName, size: subtitleFontSize))
                .padding()
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(model.offers ?? [], id: \.self.id) { offer in
                        ConcertView(cellImagePrompt: cellImagePrompt, cellImageWidth: cellImageWidth, cellImageHeight: cellImageHeight, concert: offer)
                     }
                     .listStyle(.plain)
                }
            }
            .frame(height: scrollViewHeight)
            .scrollIndicators(.hidden)
            .padding(.leading)
            Spacer()
        }
        .onAppear() {
            model.getData()
        }
    }
}

fileprivate struct LocationsView: View {
    
    @Binding var departureCity: String
    let departureCityPrompt: String
    let arrivalCityPrompt: String
    
    let searchViewHeight: CGFloat
    
    let action: () -> Void
    
    var body: some View {
        HStack {
            Image("magnifierIcon")
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.leading, 8)
            VStack(alignment: .leading) {
                TextField("",
                          text: $departureCity,
                          prompt: Text(departureCityPrompt)
                    .foregroundColor(.gray)
                )
                Divider()
                    .background(Color(hex: "#9F9F9F"))
                HStack {
                    Text(arrivalCityPrompt)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .onTapGesture() {
                        action()
                    }
            }
        }
        .padding(.trailing)
            .frame(height: searchViewHeight)
            .background {
                            RoundedRectangle(cornerRadius: 16)
                    .fill(Color(hex: "#3E3F43"))
                                .shadow(radius: 2, y: 2)
                        }
        .padding(16)
        .background {
                        RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#2F3035"))
                            .shadow(radius: 2, y: 2)
                    }
    }
}

fileprivate struct ConcertView: View {
    
    let cellImagePrompt: String
    let cellImageWidth: CGFloat
    let cellImageHeight: CGFloat
    let id: String
    let title: String
    let town: String
    let price: String
    
    init(cellImagePrompt: String, cellImageWidth: CGFloat, cellImageHeight: CGFloat, concert: HomeViewData.Offer) {
        self.cellImagePrompt = cellImagePrompt
        self.cellImageWidth = cellImageWidth
        self.cellImageHeight = cellImageHeight
        self.id = String(concert.id)
        self.title = concert.title
        self.town = concert.town
        self.price = concert.price.value.formatted()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(cellImagePrompt+id)
                .resizable()
                .frame(width: cellImageWidth, height: cellImageHeight)
                .cornerRadius(16)
            Text(title)
                .font(.title3) // TODO: set font
            Text(town)
            HStack(spacing: 0) {
                Image("concertFlightIcon")
                    .foregroundColor(.gray)
                Text("от " + price + " ₽")
            }
        }
    }
}

// MARK: - Preview
#Preview {
    HomeView(model: HomeViewModel(coordinator: Coordinator()))
        .preferredColorScheme(.dark)
}
