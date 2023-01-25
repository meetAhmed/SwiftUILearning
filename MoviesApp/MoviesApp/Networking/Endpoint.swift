//
//  Endpoint.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 25/01/2023.
//

import Foundation

enum Endpoint {
    case discoverMovies
    case genres
}

extension Endpoint {
    var fullPath: String {
        base + path
    }
}

private extension Endpoint {
    var base: String {
        "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .discoverMovies:
            return "/3/discover/movie"
        case .genres:
            return "/3/genre/movie/list"
        }
    }
}
