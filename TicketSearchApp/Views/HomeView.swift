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
    private let searchViewHeight = 160.0
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
            List {
                TextField("",
                          text: $model.departureCity,
                          prompt: Text(model.strings.departureCityPrompt)
                    .foregroundColor(.gray)
                )
                TextField("",
                          text: $model.arrivalCity,
                          prompt: Text(model.strings.departureCityPrompt)
                    .foregroundColor(.gray)
                )
                .onTapGesture {
                    model.userInititatedArrivalCityTextEdit()
                }
            }
            .frame(height: searchViewHeight) // TODO: handle size
            Text(model.strings.subTitle)
                .font(.custom(model.fontName, size: subtitleFontSize))
                .padding(.vertical)
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(model.offers ?? [], id: \.self.id) { offer in
                        VStack(alignment: .leading) {
                            Image(cellImagePrompt+"\(offer.id)")
                                .resizable()
                                .frame(width: cellImageWidth, height: cellImageHeight)
                            Text(offer.title)
                            Text(offer.town)
                            Text("\(offer.price.value)")
                        }
                     }
                     .listStyle(.plain)
                }
            }
            .frame(height: scrollViewHeight)
            Spacer()
        }
        .padding()
        .onAppear() {
            model.getData()
        }
    }
}

// MARK: - Preview
#Preview {
    HomeView(model: HomeViewModel())
        .environmentObject(Coordinator())
}
