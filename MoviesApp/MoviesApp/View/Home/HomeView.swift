//
//  HomeView.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 25/01/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var selected: Genre = Genre(id: 1, name: "Test")
    @Namespace var namespace
    
    var body: some View {
        VStack {
            if let error = viewModel.error {
                Text("Error: \(error.localizedDescription)")
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.genres) { genre in
                        GenreCard(genre: genre, selected: $selected, namespace: namespace)
                    }
                }
            }
            
            Spacer()
        }
        .navigationBarTitle("Movies")
        .padding()
        .task {
            await viewModel.fetchGenres()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}
