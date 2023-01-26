//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 25/01/2023.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    @Published var genres: [Genre] = []
    @Published var movies: [Movie] = []
    @Published var trendingMovies: [Movie] = []
    @Published var error: Error?
    @Published var searchedText = ""
    
    private let movieService = MoviesNetworkingService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubcriber()
    }
    
    func fetchGenres() async {
        do {
            let response: GenreApiResponse = try await movieService.fetchData(api: APIConstructor(endpoint: .genres))
            await MainActor.run(body: {
                genres = response.genres
            })
        } catch {
            self.error = error
        }
    }
    
    func fetchMovies() async {
        do {
            let api = APIConstructor(endpoint: .discoverMovies, queryParams: [
                "sort_by": "release_date.desc",
                "genre": "28"
            ])
            let response: MovieApiResponse = try await movieService.fetchData(api: api)
            await MainActor.run(body: {
                movies = response.results
            })
        } catch {
            self.error = error
        }
    }
    
    func fetchTrending() async {
        do {
            let response: MovieApiResponse = try await movieService.fetchData(api: APIConstructor(endpoint: .trending))
            await MainActor.run(body: {
                trendingMovies = response.results
            })
        } catch {
            self.error = error
        }
    }
    
    func searchMovies(query: String) {
    }
}

private extension HomeViewModel {
    func addSubcriber() {
        $searchedText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { str in
                self.searchMovies(query: str)
            }
            .store(in: &cancellables)
    }
}
