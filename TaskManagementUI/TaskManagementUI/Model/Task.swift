//
// Task.swift
// TaskManagementUI
//
// Created by Ahmed Ali
//

import Foundation

struct Task: Identifiable {
    var id = UUID().uuidString
    var dateAdded: Date
    var taskName: String
    var taskDescription: String
    var taskCategory: Category
}

class TaskDataService {
    static let tasks: [Task] = [
        .init(dateAdded: Date(timeIntervalSince1970: 1673854452), taskName: "Go for Walk!", taskDescription: "Stop being lazy and go for walk to stay fit and healthy.", taskCategory: .challenge),
        .init(dateAdded:  Date(timeIntervalSince1970: 1674027252), taskName: "Order Cake", taskDescription: "Order cake via Foodpanda App.", taskCategory: .general),
        .init(dateAdded:  Date(timeIntervalSince1970: 1674113652), taskName: "Watch a movie.", taskDescription: "Watch a good comedy movie.", taskCategory: .idea),
        .init(dateAdded:  Date(timeIntervalSince1970: 1674088452), taskName: "Some Random Title.", taskDescription: "", taskCategory: .modifiers),
        .init(dateAdded:  Date(timeIntervalSince1970: 1674210852), taskName: "Lorem Isporem", taskDescription: "", taskCategory: .general),
        .init(dateAdded: Date(timeIntervalSince1970: 1674210852), taskName: "Go for Walk!", taskDescription: "Stop being lazy and go for walk to stay fit and healthy.", taskCategory: .coding),
    ]
}
