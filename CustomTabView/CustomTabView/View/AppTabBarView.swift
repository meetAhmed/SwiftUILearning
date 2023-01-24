//
// AppTabBarView.swift
// CustomTabView
//
// Created by Ahmed Ali
//

import SwiftUI

struct AppTabBarView: View {
    @State private var selection: TabBarItem = .home
    
    var body: some View {
        CustomTabBarContainerView(selection: $selection) {
            Color.red
                .tabBarItem(tab: .home, selection: $selection)
            
            Color.blue
                .tabBarItem(tab: .profile, selection: $selection)
            
            Color.green
                .tabBarItem(tab: .favorite, selection: $selection)
        }
    }
}

struct AppTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabBarView()
    }
}
