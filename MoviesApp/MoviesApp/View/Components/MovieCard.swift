//
//  MovieCard.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 26/01/2023.
//

import SwiftUI

enum MovieCardType {
    case trending, grid
}

struct MovieCard: View {
    let movie: Movie
    var type: MovieCardType = .trending

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: movie.imageFullPath)) { image in
                image
                    .resizable()
            } placeholder: {
                ZStack {
                    Color.placeholder
                    
                    VStack(spacing: 10) {
                        Image(systemName: "photo")
                            .font(.system(size: 30))
                        
                        Text(movie.title)
                            .poppins(.light, 14)
                    }
                    .foregroundColor(.white)
                    .padding()
                }
                .frame(width: itemWidth, height: itemHeight)
            }
            .scaledToFill()
            .frame(width: itemWidth, height: itemHeight)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

struct MovieCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MovieCard(movie: dev.movie, type: .trending)
            MovieCard(movie: dev.movie, type: .grid)
        }
        .padding()
    }
}

private extension MovieCard {
    var itemWidth: CGFloat {
        UIScreen.main.bounds.width * (type == .trending ? 0.6 : 0.3)
    }
    
    var itemHeight: CGFloat {
        UIScreen.main.bounds.height * (type == .trending ? 0.38 : 0.2)
    }
}
