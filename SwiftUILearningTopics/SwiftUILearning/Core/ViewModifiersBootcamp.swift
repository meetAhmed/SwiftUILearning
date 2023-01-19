//
// ViewModifiersBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    let background: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(background)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
    }
}

extension View {
    func withDefaultButtonFormatting(background: Color = .blue) -> some View {
        modifier(DefaultButtonViewModifier(background: background))
    }
}

struct ViewModifiersBootcamp: View {
    var body: some View {
        VStack {
            Text("Hello World")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(.blue)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding()
            
            Text("Hello Another World!")
                .withDefaultButtonFormatting(background: .green)
            
            Text("Login")
                .font(.title)
                .withDefaultButtonFormatting()
        }
    }
}

struct ViewModifiersBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifiersBootcamp()
    }
}
