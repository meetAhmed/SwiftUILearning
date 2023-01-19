//
// SubscriberBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import Combine
import SwiftUI

class SubscriberViewModel: ObservableObject {
    @Published var count = 0
    @Published var textFieldText = ""
    @Published var textIsValid = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupTimer()
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            .map { (text) -> Bool in
                text.count > 10
            }
            .sink { [weak self] returnedValue in
                self?.textIsValid = returnedValue
            }
            .store(in: &cancellables)
    }
    
    func setupTimer() {
        Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.count += 1
            }
            .store(in: &cancellables)
    }
}

struct SubscriberBootcamp: View {
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            TextField("Type something here...", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
                .overlay(
                    ZStack {
                        Image(systemName: vm.textIsValid ? "checkmark" : "xmark")
                            .foregroundColor(vm.textIsValid ? .green : .red)
                    }
                    .font(.title)
                    .padding(.trailing)
                    
                    , alignment: .trailing
                )
        }
    }
}

struct SubscriberBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberBootcamp()
    }
}
