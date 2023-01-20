//
// Array.swift
// TaskManagementUI
//
// Created by Ahmed Ali
//

import Foundation

extension Array where Element == Task {
    func filterTasksFor(date: Date, time: Date, tasks: [Task]) -> [Task] {
        let calendar = Calendar.current
        return tasks.filter {
            if let hour = calendar.dateComponents([.hour], from: time).hour,
               let taskHour = calendar.dateComponents([.hour], from: $0.dateAdded).hour,
               hour == taskHour && calendar.isDate($0.dateAdded, inSameDayAs: date) {
                return true
            }
            return false
        }
    }
}
