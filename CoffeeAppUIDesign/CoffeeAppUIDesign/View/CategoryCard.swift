//
//  CategoryCard.swift
//  CoffeeAppUIDesign
//
//  Created by Ahmed Ali on 01/02/2023.
//

import SwiftUI

struct CategoryCard: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("CoffeeBackground")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.height * 0.18)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text("Cappuccino")
                .font(.headline)
            
            Text("With Chocolate")
                .font(.caption)
            
            Text("50 k")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .padding(.all, 10)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
        )
        .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 0)
        .padding(.horizontal, 5)
    }
}

struct CategoryCard_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCard()
    }
}
