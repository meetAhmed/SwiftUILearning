//
// BackgroundThreadsBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func fetchData() {
        DispatchQueue.global().async {
            let newData = self.downloadData()
            print("Check1: IsMainThread: \(Thread.isMainThread) Current: \(Thread.current)")
            DispatchQueue.main.async {
                self.dataArray = newData
                print("Check2: IsMainThread: \(Thread.isMainThread) Current: \(Thread.current)")
            }
        }
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        for x in 0..<100 {
            data.append("\(x)")
            print("\(x)")
        }
        return data
    }
}

struct BackgroundThreadsBootcamp: View {
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Load Data")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { data in
                    Text(data)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct BackgroundThreadsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadsBootcamp()
    }
}
