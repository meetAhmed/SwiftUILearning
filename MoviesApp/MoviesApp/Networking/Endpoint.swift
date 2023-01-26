//
//  Endpoint.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 25/01/2023.
//

import Foundation

enum Endpoint {
    case trending
    case discoverMovies
    case genres
}

extension Endpoint {
    var fullPath: String {
        base + path
    }
    
    static var imageBaseUrl: String {
        "https://image.tmdb.org/t/p/original"
    }
}

private extension Endpoint {
    var base: String {
        "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .trending:
            return "/3/trending/movie/week"
        case .discoverMovies:
            return "/3/discover/movie"
        case .genres:
            return "/3/genre/movie/list"
        }
    }
}