//
// Category.swift
// TaskManagementUI
//
// Created by Ahmed Ali
//

import SwiftUI

enum Category: String, CaseIterable {
    case general, bug, idea, modifiers, challenge, coding
    
    var color: Color {
        switch self {
        case .general:
            return .indigo
        case .bug:
            return .red
        case .idea:
            return .green
        case .modifiers:
            return .blue
        case .challenge:
            return .orange
        case .coding:
            return .brown
        }
    }
}
