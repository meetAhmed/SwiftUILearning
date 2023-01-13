//
// HashableBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import SwiftUI

struct CustomHashModel: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct HashableBootcamp: View {
    let data: [CustomHashModel] = [
        CustomHashModel(title: "One"),
        CustomHashModel(title: "Two"),
        CustomHashModel(title: "Three")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(data, id: \.self) { item in
                    Text(item.title)
                        .font(.headline) 
                }
            }
        }
    }
}

struct HashableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HashableBootcamp()
    }
}
