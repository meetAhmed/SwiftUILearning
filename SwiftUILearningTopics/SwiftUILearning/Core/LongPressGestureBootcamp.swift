//
// LongPressGestureBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import SwiftUI

struct LongPressGestureBootcamp: View {
    @State var isComplete = false
    @State var isSuccess = false
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
            
            HStack {
                Text("Click me")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50.0) { isPressing in
                        // start of press -> min duration
                        if isPressing {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                isComplete = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if !isSuccess {
                                    withAnimation(.easeInOut) {
                                        isComplete = false
                                    }
                                }
                            }
                        }
                    } perform: {
                        // at the min duration
                        withAnimation(.easeInOut(duration: 1.0)) {
                            isSuccess = true
                        }
                    }
                
                Text("Reset")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .onTapGesture {
                        isComplete = false
                        isSuccess = false 
                    }
            }
        }
//        Text(isComplete ? "Completed" : "Not Completed")
//            .padding()
//            .padding(.horizontal)
//            .background(isComplete ? Color.green : Color.red)
//            .cornerRadius(10)
//            .onLongPressGesture(minimumDuration: 3.0, maximumDistance: 50.0) {
//                isComplete.toggle()
//            }
    }
}

struct LongPressGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureBootcamp()
    }
}
