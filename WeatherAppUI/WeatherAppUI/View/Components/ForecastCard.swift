//
//  ForecastCard.swift
//  WeatherAppUI
//
//  Created by Ahmed Ali on 25/01/2023.
//

import SwiftUI

struct ForecastCard: View {
    let forecast: Forecast
    let forecastPeriod: ForecastPeriod
    var isActive: Bool {
        Calendar.current.isDate(.now, equalTo: forecast.date, toGranularity: forecastPeriod == .hourly ? .hour : .day)
    }
    
    var body: some View {
        ZStack {
            // MARK: Card
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.forecastCardBackground.opacity(isActive ? 1.0 : 0.2))
                .frame(width: 60, height: 146)
                .shadow(color: .black.opacity(0.25), radius: 10, x: 5, y: 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(.white.opacity(isActive ? 0.5 : 0.2))
                        .blendMode(.overlay)
                )
                .innerShadow(shape: RoundedRectangle(cornerRadius: 30), color: .white.opacity(0.25), blendMode: .overlay)
            
            VStack(spacing: 16) {
                Text(forecast.date, format: forecastPeriod == .hourly ? .dateTime.hour() : .dateTime.weekday())
                    .font(.subheadline.weight(.semibold))
                
                VStack(spacing: -4) {
                    Image("\(forecast.icon) small")
                    
                    Text(forecast.probability, format: .percent)
                        .font(.footnote.weight(.semibold))
                        .foregroundColor(Color.probabilityText)
                        .opacity(forecast.probability > 0 ? 1 : 0)
                }
                .frame(height: 42)
                
                Text("\(forecast.temperature) °")
                    .font(.title3)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .frame(width: 60, height: 146)
        }
    }
}

struct ForecastCard_Previews: PreviewProvider {
    static var previews: some View {
        ForecastCard(forecast: Forecast.hourly.first!, forecastPeriod: ForecastPeriod.weekly)
    }
}
