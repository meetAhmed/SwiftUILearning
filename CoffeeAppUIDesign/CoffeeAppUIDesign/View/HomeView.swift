//
//  HomeView.swift
//  CoffeeAppUIDesign
//
//  Created by Ahmed Ali on 01/02/2023.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                Image("UserImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                
                Spacer()
                
                Text("Bintara, Bekasi")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "bell")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Good Morning")
                .font(.headline)
                .padding(.top, 14)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .frame(width: 24, height: 24)
                
                TextField("Search", text: $searchText)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 100)
                    .fill(Color("SearchBoxColor"))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .stroke(.black.opacity(0.1), lineWidth: 1)
            )
            .padding(.top, 15)
            
            Text("Categories")
                .font(.headline)
                .padding(.top, 15)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<10) { _ in
                        ProductCard()
                    }
                }
                .padding(.vertical)
            }
            
            SpecialOfferCard()
            
            Spacer()
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
