//
//  PreviewProvider.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 26/01/2023.
//

import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() {}
    
    let genre = Genre(id: 28, name: "Action")
    
    let namespace = Namespace().wrappedValue
    
    let movie = Movie(
        adult: false,
        backdropPath: "/xC6K2KflIbcajMeROYUsxqeJT1p.jpg",
        genreIDS: [28, 35],
        id: 936622,
        originalLanguage: "hi",
        originalTitle: "Bade Miyan Chote Miyan",
        overview: "",
        popularity: 2.104,
        posterPath: "/yOgoRI240jaA1mrl4EXnxP7dk11.jpg",
        releaseDate: "2023-12-25",
        title: "Bade Miyan Chote Miyan",
        video: false,
        voteAverage: 0,
        voteCount: 0
    )
}
