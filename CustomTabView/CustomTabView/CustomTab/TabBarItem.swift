//
// TabBarItem.swift
// CustomTabView
//
// Created by Ahmed Ali
//

import SwiftUI

enum TabBarItem: Hashable {
    case home, favorite, profile
    
    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .favorite:
            return "heart"
        case .profile:
            return "person"
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .favorite:
            return "Favorite"
        case .profile:
            return "Profile"
        }
    }
    
    var color: Color {
        switch self {
        case .home:
            return .pink
        case .favorite:
            return .green
        case .profile:
            return .blue
        }
    }
}
