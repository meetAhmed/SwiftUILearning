//
//  GenreCard.swift
//  MoviesApp
//
//  Created by Ahmed Ali on 25/01/2023.
//

import SwiftUI

struct GenreCard: View {
    let genre: Genre
    @Binding var selected: Genre
    var namespace: Namespace.ID
    
    var body: some View {
        VStack {
            Text(genre.name)
                .font(.headline)
        }
        .padding()
        .background(
            ZStack {
                if selected == genre {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray.opacity(0.1))
                        .matchedGeometryEffect(id: "GenreCard", in: namespace)
                }
            }
        )
        .onTapGesture {
            withAnimation(.easeInOut) {
                selected = genre
            }
        }
    }
}

struct GenreCard_Previews: PreviewProvider {
    static var previews: some View {
        let genre = Genre(id: 1, name: "Action")
        let namespace = Namespace()
        GenreCard(genre: genre, selected: .constant(genre), namespace: namespace.wrappedValue)
    }
}
