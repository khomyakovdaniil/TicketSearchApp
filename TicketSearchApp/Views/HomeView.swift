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
    private let titleViewHeight = 54.0
    private let subtitleFontSize = 22.0
    private let searchViewHeight = 90.0
    private let scrollViewHeight = 214.0
    
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Spacer()
                Text(model.strings.title)
                    .font(.custom(model.fontName, size: titleFontSize))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(hex: "#D9D9D9"))
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
                        ConcertView(concert: offer)
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
                .font(.custom("SFProDisplay-Bold", size: 16))
                Divider()
                    .background(Color(hex: "#9F9F9F"))
                HStack {
                    Text(arrivalCityPrompt)
                        .foregroundColor(.gray)
                        .font(.custom("SFProDisplay-Bold", size: 16))
                    Spacer()
                }
                .contentShape(.rect)
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
    
    private let cellImagePrompt = "HomeViewImage"
    private let cellImageHeight = 132.0
    private let cellImageWidth = 132.0
    let id: String
    let title: String
    let town: String
    let price: String
    
    init(concert: HomeViewData.Offer) {
        self.id = String(concert.id)
        self.title = concert.title
        self.town = concert.town
        self.price = concert.price.value.priceFormatted()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image(cellImagePrompt+id)
                .resizable()
                .frame(width: cellImageWidth, height: cellImageHeight)
                .cornerRadius(16)
            Text(title)
                .font(.custom("SFProDisplay-Bold", size: 16))
            Text(town)
                .font(.custom("SFProDisplay-Regular", size: 14))
            HStack(spacing: 0) {
                Image("concertFlightIcon")
                    .foregroundColor(.gray)
                Text(Constants.HomeView.priceFrom + price + " ₽")
            }
        }
    }
}

// MARK: - Preview
#Preview {
    HomeView(model: HomeViewModel(coordinator: Coordinator()))
        .preferredColorScheme(.dark)
}
