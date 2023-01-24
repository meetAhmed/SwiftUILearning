//
//  HomeView.swift
//  WeatherAppUI
//
//  Created by Ahmed Ali on 24/01/2023.
//

import BottomSheet
import SwiftUI

enum BottomSheetPosition: CGFloat, CaseIterable {
    case top = 0.83
    case middle = 0.385
}

struct HomeView: View {
    @State var bottomSheetPosition: BottomSheetPosition = .middle
    @State var bottomSheetTransalation: CGFloat = BottomSheetPosition.middle.rawValue
    @State var dragged = false
    
    var bottomSheetTranslationProrated: CGFloat {
        (bottomSheetTransalation - BottomSheetPosition.middle.rawValue) / (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
    }
    
    var body: some View {
        GeometryReader { geometry in
            let screenHeight = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
            let imageOffset = screenHeight + 36
            ZStack {
                // MARK: Background Color
                Color.background
                    .ignoresSafeArea()
                
                // MARK: Background Image
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                    .offset(y: -bottomSheetTranslationProrated * imageOffset)
                
                // MARK: House Image
                Image("House")
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top, 257)
                    .offset(y: -bottomSheetTranslationProrated * imageOffset)
                
                VStack {
                    Text("Montreal")
                        .font(.largeTitle)
                    
                    VStack {
                        Text(attributedString)
                        
                        Text("H:24°   L:18°")
                            .font(.title3.weight(.semibold))
                            .opacity(1 - bottomSheetTranslationProrated)
                    }
                    
                    Spacer()
                }
                .padding(.top, 51)
                .offset(y: -bottomSheetTranslationProrated * 46)
                
                // MARK: Bottom Sheet
                BottomSheetView(position: $bottomSheetPosition) {} content: {
                    ForecastView(bottomSheetTranslationProrated: bottomSheetTranslationProrated)
                }
                .onBottomSheetDrag { translation in
                    bottomSheetTransalation = translation / screenHeight
                    withAnimation(.easeInOut) {
                        dragged = bottomSheetPosition == BottomSheetPosition.top
                    }
                }
                
                // MARK: Tab Bar
                TabBar {
                    withAnimation(.easeInOut) {
                        bottomSheetPosition = .top
                    }
                }
                .offset(y: bottomSheetTranslationProrated * 150)
            }
            .navigationBarHidden(true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}

private extension HomeView {
    var attributedString: AttributedString {
        var string = AttributedString("19°" + (dragged ?  " | " : "\n ") + "Mostly Clear")
        if let temp = string.range(of: "19°") {
            string[temp].font = .system(size: 96 - (bottomSheetTranslationProrated * (96 - 20)), weight: dragged ? .semibold : .thin)
            string[temp].foregroundColor = dragged ? .secondary : .primary
        }
        
        if let pipe = string.range(of: " | ") {
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary.opacity(bottomSheetTranslationProrated)
        }
        
        if let weather = string.range(of: "Mostly Clear") {
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .secondary
        }
        
        return string
    }
}
