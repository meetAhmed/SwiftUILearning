//
//  CategoryCard.swift
//  CoffeeAppUIDesign
//
//  Created by Ahmed Ali on 01/02/2023.
//

import SwiftUI

struct ProductCard: View {
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                Image("CoffeeBackground")
                    .resizable()
                    .scaledToFill()
                    .frame(width: cardImageWidth, height: cardImageHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                HStack {
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 10, height: 10)
                    
                    Text("4.9")
                }
                .padding(.all, 6)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.darkBrownColor)
                )
                .frame(height: 20)
                .font(.caption2)
                .foregroundColor(.white)
                .padding(.all, 10)
            }
            
            Text("Cappuccino")
                .font(.headline)
            
            Text("With Chocolate")
                .font(.caption)
            
            HStack {
                Text("$12.5")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                ZStack {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 10, height: 10)
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .frame(width: 30, height: 30)
                .background(
                    Circle()
                        .fill(Color.darkBrownColor)
                )
            }
        }
        .frame(width: cardImageWidth)
        .padding(.all, 10)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
        )
        .shadow(color: .gray.opacity(0.15), radius: 7, x: 2, y: 1)
        .padding(.horizontal, 5)
    }
}

struct CategoryCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard()
    }
}

private extension ProductCard {
    var cardImageHeight: CGFloat {
        UIScreen.main.bounds.height * 0.18
    }
    
    var cardImageWidth: CGFloat {
        UIScreen.main.bounds.width * 0.45
    }
}
