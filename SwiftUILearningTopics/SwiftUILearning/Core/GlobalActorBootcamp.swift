//
// GlobalActorBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import SwiftUI

@globalActor struct MyFirstGlobalActor {
    static var shared = MyNewDataManager()
}

actor MyNewDataManager {
    nonisolated func getDataFromDatabase() -> [String] {
        ["1", "2", "3"]
    }
}

class GlobalActorBootcampViewModel: ObservableObject {
    @MainActor @Published var data: [String] = []
    let manager = MyFirstGlobalActor.shared
    
    @MyFirstGlobalActor
    func getData() async {
        await MainActor.run {
            self.data = manager.getDataFromDatabase()
        }
    }
}

struct GlobalActorBootcamp: View {
    @StateObject private var vm = GlobalActorBootcampViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.data, id: \.self) {
                    Text($0)
                        .font(.headline)
                }
            }
        }
        .task {
            await vm.getData()
        }
    }
}

struct GlobalActorBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GlobalActorBootcamp()
    }
}
