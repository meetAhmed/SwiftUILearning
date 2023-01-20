//
// Calendar.swift
// TaskManagementUI
//
// Created by Ahmed Ali
//

import Foundation

struct WeekDay: Identifiable {
    var id = UUID().uuidString
    var string: String
    var date: Date
    var isToday: Bool
}

extension Calendar {
    var currentWeek: [WeekDay] {
        guard let firstDayOfWeek  = dateInterval(of: .weekOfMonth, for: Date())?.start else { return [] }
        var week = [WeekDay]()
        for index in 0..<7 {
            if let day = date(byAdding: .day, value: index, to: firstDayOfWeek) {
                let weekDaySymbol = day.toString(.dayOnly)
                let isToday = isDateInToday(day)
                week.append(.init(string: weekDaySymbol, date: day, isToday: isToday))
            }
        }
        return week
    }
    
    var hours: [Date] {
        let startDay = startOfDay(for: Date())
        var hours = [Date]()
        for index in 0..<24 {
            if let day = date(byAdding: .hour, value: index, to: startDay) {
                hours.append(day)
            }
        }
        return hours
    }
}
