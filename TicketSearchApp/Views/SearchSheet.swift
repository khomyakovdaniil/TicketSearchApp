//
//  SearchSheet.swift
//  TicketSearchApp
//
//  Created by  Даниил Хомяков on 01.06.2024.
//

import SwiftUI
import Combine

// MARK: - MainView
struct SearchSheet: View {
    
    // MARK: ViewModel
    @StateObject var model: SearchSheetViewModel
    
    // MARK: Private constants
    private let searchViewHeight = 90.0
    
    // MARK: View
    var body: some View {
        VStack(alignment: .leading) {
            LocationsView(departureCityTextValidator: TextValidator(text: model.departureCity),
                          arrivalCityTextValidator: TextValidator(text: model.arrivalCity),
                          departureCity: $model.departureCity,
                          arrivalCity: $model.arrivalCity,
                          departureCityPrompt: model.strings.departureCityPrompt,
                          arrivalCityPrompt: model.strings.arrivalCityPrompt) {
                model.userEnteredArrivalCity()
            }
                          .padding()
            HStack(spacing: 0) {
                ForEach(model.actions, id: \.self.text) { action in
                    ActionView(action)
                }
            }
            .padding(.top)
            VStack {
                ForEach(model.suggestions, id: \.self.text) { suggestion in
                    SuggestionView(popularDestinationString: model.strings.popularDestination, data: suggestion) {
                        model.arrivalCity = suggestion.text
                        model.userEnteredArrivalCity()
                    }
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(hex: "#2F3035"))
                    .shadow(radius: 2, y: 2)
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}

// MARK: - Subviews

// MARK: - LocationsView
fileprivate struct LocationsView: View {
    
    // MARK: Input validation
    @ObservedObject var departureCityTextValidator: TextValidator
    @ObservedObject var arrivalCityTextValidator: TextValidator
    
    // MARK: Private properies
    private let searchViewHeight = 96.0
    
    // MARK: Properies
    @Binding var departureCity: String
    @Binding var arrivalCity: String
    let departureCityPrompt: String
    let arrivalCityPrompt: String
    let action: () -> Void
    
    // MARK: View
    var body: some View {
        VStack {
            HStack {
                Image("planeIcon")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray)
                TextField("",
                          text: $departureCityTextValidator.text,
                          prompt: Text(departureCityPrompt)
                    .foregroundColor(.gray)
                )
                .onReceive(Just(departureCityTextValidator.text)) { newValue in
                    guard let lastCharacter = newValue.last else {
                        return
                    }
                    if !departureCityTextValidator.allowedCharacters.contains(String(lastCharacter)) {
                        self.departureCityTextValidator.text = String(newValue.dropLast())
                    }
                    print(newValue)
            }
                .font(.custom("SFProDisplay-Bold", size: 16))
                .onSubmit {
                    departureCity = departureCityTextValidator.text
                }
            }
            Divider()
                .background(Color(hex: "#9F9F9F"))
            HStack {
                Image("magnifierIcon")
                    .resizable()
                    .frame(width: 24, height: 24)
                TextField("",
                          text: $arrivalCityTextValidator.text,
                          prompt: Text(arrivalCityPrompt)
                    .foregroundColor(.gray)
                )
                .onReceive(Just(arrivalCityTextValidator.text)) { newValue in
                    guard let lastCharacter = newValue.last else {
                        return
                    }
                    if !arrivalCityTextValidator.allowedCharacters.contains(String(lastCharacter)) {
                        self.arrivalCityTextValidator.text = String(newValue.dropLast())
                    }
                    print(newValue)
            }
                .font(.custom("SFProDisplay-Bold", size: 16))
                .onSubmit() {
                    arrivalCity = arrivalCityTextValidator.text
                    action()
                }
                Spacer()
                Image(systemName: "xmark")
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        arrivalCity = ""
                    }
            }
        }
        .padding()
        .frame(height: searchViewHeight) // TODO: handle size
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "#2F3035"))
                .shadow(radius: 2, y: 2)
        }
    }
}

// MARK: - ActionsView
fileprivate struct ActionView: View {
    
    // MARK: Properties
    let imageName: String
    let text: String
    let action: @MainActor () -> Void
    
    // MARK: Private properties
    private let actionCellImageHeight = 48.0
    private let actionCellImageWidth = 48.0
    private let actionFontSize = 14.0
    
    // MARK: Convenience init
    init(_ data: SearchSheetViewModel.ActionData) {
        imageName = data.imagename
        text = data.text
        action = data.action
    }
    
    // MARK: View
    var body: some View {
        VStack(alignment: .center) {
            Image(imageName)
                .resizable()
                .frame(width: actionCellImageWidth, height: actionCellImageHeight)
            Text(text)
                .font(.custom("SFProDisplay-Regular", size: actionFontSize))
                .multilineTextAlignment(.center)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 114)
        .onTapGesture {
            action()
        }
    }
}

// MARK: - SuggestionView
fileprivate struct SuggestionView: View {
    
    // MARK: Properties
    let imageName: String
    let text: String
    let action: @MainActor () -> Void
    let popularDestinationString: String
    let suggestionCellImageHeight = 40.0
    let suggestionCellImageWidth = 40.0
    
    // MARK: Convenience init
    init(popularDestinationString: String, data: SearchSheetViewModel.SuggestionData, action: @escaping @MainActor () -> Void) {
        imageName = data.imagename
        text = data.text
        self.action = action
        self.popularDestinationString = popularDestinationString
    }
    
    // MARK: View
    var body: some View {
        VStack {
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: suggestionCellImageWidth, height: suggestionCellImageHeight)
                    .clipped()
                    .cornerRadius(8)
                VStack(alignment: .leading) {
                    Text(text)
                        .font(.custom("SFProDisplay-Bold", size: 16))
                    Text(popularDestinationString)
                        .foregroundColor(.gray)
                        .font(.custom("SFProDisplay-Regular", size: 14))
                }
                Spacer()
            }
            .padding(.top, 6)
            Divider()
                .background(Color(hex: "#9F9F9F"))
        }
        .onTapGesture {
            action()
        }
    }
}

// MARK: - Preview
#Preview {
    SearchSheet(model: SearchSheetViewModel(coordinator: Coordinator()))
        .preferredColorScheme(.dark)
}
