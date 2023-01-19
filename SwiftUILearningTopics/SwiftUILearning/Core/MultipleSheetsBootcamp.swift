//
// MultipleSheetsBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

struct MultipleSheetsBootcamp: View {
    @State var randomModel: RandomModel?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<30) { index in
                    Button("Button \(index)") {
                        randomModel = RandomModel(title: "\(index)")
                    }
                }
            }
            .sheet(item: $randomModel) { model in
                NextScreen(model: model)
            }
        }
    }
}

struct NextScreen: View {
    let model: RandomModel
    
    var body: some View {
        VStack {
            Text("\(model.title)")
                .font(.headline)
            
            Text("\(model.id)")
                .font(.caption)
        }
    }
}

struct MultipleSheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsBootcamp()
    }
}
