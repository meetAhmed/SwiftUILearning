//
//  HomeView.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 25/01/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var selected: Genre = DeveloperPreview.instance.genre
    @Namespace var namespace
    
    var body: some View {
        ScrollView {
            VStack {
                if let error = viewModel.error {
                    Text("Error: \(error.localizedDescription)")
                }
                
                Text("What do you want to watch?")
                    .poppins(.medium, 18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                SearchBar(searchedText: $viewModel.searchedText)
                
                if viewModel.searchedText.isEmpty {
                    trendingView
                    
                    genreView
                } else {
                    
                }
            }
        }
        .padding()
        .background(Color.appBackground)
        .environment(\.colorScheme, .dark)
        .task {
            await viewModel.fetchGenres()
            await viewModel.fetchMovies()
            await viewModel.fetchTrending()
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

private extension HomeView {
    var trendingView: some View {
        VStack {
            Text("Trending Now")
                .poppins(.medium, 18)
                .hAlign(.leading)
                .padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(viewModel.trendingMovies) { movie in
                        MovieCard(movie: movie)
                    }
                }
            }
        }
    }
    
    var genreView: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.genres) { genre in
                        GenreCard(genre: genre, selected: $selected, namespace: namespace)
                    }
                }
            }
            .padding(.top, 20)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(viewModel.trendingMovies) { movie in
                    MovieCard(movie: movie, type: .grid)
                }
            }
            .padding(.top, 20)
        }
    }
    
    var searchedList: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
            ForEach(viewModel.trendingMovies) { movie in
                MovieCard(movie: movie, type: .grid)
            }
        }
        .padding(.top, 20)
    }
}
