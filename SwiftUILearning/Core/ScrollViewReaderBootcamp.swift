//
// ScrollViewReaderBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {
    @State var textFieldText = ""
    @State var scrollIndex = 0
    
    var body: some View {
        VStack {
            TextField("Enter a # here...", text: $textFieldText)
                .frame(height: 55)
                .border(Color.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("Scroll Now") {
                if let index = Int(textFieldText) {
                    scrollIndex = index
                    UIApplication.shared.endEditing()
                }
            }
            
            ScrollView {
                ScrollViewReader { reader in
                    ForEach(0..<50) { index in
                        Text("This is item #\(index)")
                            .foregroundColor(Color.black)
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollIndex) { value in
                        withAnimation(.spring()) {
                            reader.scrollTo(value, anchor: .top)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct ScrollViewReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderBootcamp()
    }
}
