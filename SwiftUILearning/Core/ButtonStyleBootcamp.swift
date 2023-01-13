//
// ButtonStyleBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .brightness(configuration.isPressed ? 0.05 : 0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

extension View {
    func withPressableStyle() -> some View {
        buttonStyle(PressableButtonStyle())
    }
}

struct ButtonStyleBootcamp: View {
    var body: some View {
        Button {
            
        } label: {
            Text("Click here")
                .font(.headline)
                .withDefaultButtonFormatting()
        }
        .withPressableStyle()
        .padding()
    }
}

struct ButtonStyleBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyleBootcamp()
    }
}
