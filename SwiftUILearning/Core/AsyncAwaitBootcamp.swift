//
// AsyncAwaitBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import SwiftUI

class AsyncAwaitViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func addTitle() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataArray.append("Title 1: \(Thread.current)")
        }
    }
    
    func addTitle2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let title = "Title 2: \(Thread.current)"
            DispatchQueue.main.async {
                self.dataArray.append(title)
            }
        }
    }
    
    func addAuthor1() async {
        dataArray.append("Author 1: \(Thread.current)")
        try? await Task.sleep(nanoseconds: 4_000_000_000)
        await MainActor.run(body: {
            dataArray.append("Author 2: \(Thread.current)")
        })
    }
}

struct AsyncAwaitBootcamp: View {
    @StateObject var vm = AsyncAwaitViewModel()
    
    var body: some View {
        List {
            ForEach(vm.dataArray, id: \.self) { data in
                Text(data)
            }
        }
        .onAppear {
//            vm.addTitle()
//            vm.addTitle2()
            Task {
                await vm.addAuthor1()
                
                let finalText = "Final Text: \(Thread.current)"
                vm.dataArray.append(finalText)
            }
        }
    }
}

struct AsyncAwaitBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AsyncAwaitBootcamp()
    }
}
