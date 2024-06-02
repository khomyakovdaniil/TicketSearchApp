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
    
    // MARK: - State variables
    @FocusState private var isTextFieldFocused: Bool
    
    
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
            HStack {
                Image("magnifierIcon")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.leading, 8)
                VStack {
                    TextField("",
                              text: $model.departureCity,
                              prompt: Text(model.strings.departureCityPrompt)
                        .foregroundColor(.gray)
                    )
                    Divider()
                        .background(Color(hex: "#9F9F9F"))
                    TextField("",
                              text: $model.arrivalCity,
                              prompt: Text(model.strings.arrivalCityPrompt)
                        .foregroundColor(.gray)
                    )
                    .focused($isTextFieldFocused)
                    .onChange(of: isTextFieldFocused) { focused in
                        if focused {
                            model.userInititatedArrivalCityTextEdit()
                        }
                    }
                }
            }
            .padding(.trailing)
                .frame(height: searchViewHeight) // TODO: handle size
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
            .padding()
            Text(model.strings.subTitle)
                .font(.custom(model.fontName, size: subtitleFontSize))
                .padding()
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
            .padding(.leading)
            Spacer()
        }
        .onAppear() {
            model.getData()
        }
    }
}

// MARK: - Preview
#Preview {
    HomeView(model: HomeViewModel(coordinator: Coordinator()))
        .environmentObject(Coordinator())
}
