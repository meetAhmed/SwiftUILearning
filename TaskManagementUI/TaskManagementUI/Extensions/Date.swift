//
// Date.swift
// TaskManagementUI
//
// Created by Ahmed Ali
//

import Foundation

enum DateFormatterTypes: String {
    case monthYearOnly
    case dayOnly
    case dayAsNumOnly
    case hourWithAmOrPm
    case dayMonthYear
    case hourAndMinutes
    case debug
    
    var rawValue: String {
        switch self {
        case .monthYearOnly:
            return "MMM YYYY"
        case .dayOnly:
            return "EEEE"
        case .dayAsNumOnly:
            return "dd"
        case .hourWithAmOrPm:
            return "h a"
        case .dayMonthYear:
            return "EEEE dd, MMM YYYY"
        case .hourAndMinutes:
            return "hh:mm a"
        case .debug:
            return "dd MMM YYYY hh:mm a"
        }
    }
}

extension Date {
    func toString(_ format: DateFormatterTypes) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
}
