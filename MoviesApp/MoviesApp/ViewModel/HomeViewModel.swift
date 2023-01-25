//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 25/01/2023.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var genres: [Genre] = []
    @Published var error: Error?
    
    private let movieService = MoviesNetworkingService()
    
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
}
