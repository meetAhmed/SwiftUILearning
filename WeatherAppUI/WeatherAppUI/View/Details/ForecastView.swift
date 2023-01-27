//
//  ForecastView.swift
//  WeatherAppUI
//
//  Created by Ahmed Ali on 24/01/2023.
//

import SwiftUI

struct ForecastView: View {
    var bottomSheetTranslationProrated: CGFloat = 1
    @State private var selection = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                SegmentedControl(selection: $selection)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(selection == 0 ? Forecast.hourly : Forecast.weekly) {
                            ForecastCard(forecast: $0, forecastPeriod: selection == 0 ? .hourly : .weekly)
                        }
                        .transition(.offset(x: selection == 0 ? 430 : -430))
                    }
                    .padding(.vertical, 20)
                }
                .padding(.horizontal, 20)
            }
        }
        .background(Blur(radius: 25, opaque: true))
        .background(Color.bottomSheetBackground)
        .clipShape(RoundedRectangle(cornerRadius: 44))
        .innerShadow(shape: RoundedRectangle(cornerRadius: 44),
                     color: Color.bottomSheetBorderMiddle,
                     offsetY: 1,
                     blendMode: .overlay,
                     opacity: 1 - bottomSheetTranslationProrated
        )
        .overlay(
            Divider()
                .blendMode(.overlay)
                .background(Color.bottomSheetBorderTop)
                .frame(maxHeight: .infinity, alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 44))
        )
        .overlay(
            // MARK: Drag Indicator
            RoundedRectangle(cornerRadius: 10)
                .fill(.black.opacity(0.3))
                .frame(width: 48, height: 5)
                .frame(height: 20)
                .frame(maxHeight: .infinity, alignment: .top)
        )
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
            .background(Color.background)
            .preferredColorScheme(.dark)
    }
}
