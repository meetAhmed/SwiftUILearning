//
// AsyncPublisherBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import Combine
import SwiftUI

actor AsyncPublisherDataManager {
    @Published var data: [String] = []
    
    func addData() async {
        data.append("Apple")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        data.append("Banana")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        data.append(contentsOf: ["Red", "Green", "Blue"])
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        data.append("Yellow")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        data.append(contentsOf: ["Summer", "Winter"])
        try? await Task.sleep(nanoseconds: 2_000_000_000)
    }
}

class AsyncPublisherBootcampViewModel: ObservableObject {
    @MainActor @Published var data: [String] = []
    let manager = AsyncPublisherDataManager()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscriber()
    }
    
    func start() async {
        await manager.addData()
    }
    
    private func addSubscriber() {
        Task {
            for await value in await manager.$data.values {
                await MainActor.run(body: {
                    self.data = value
                })
            }
        }
        
//        manager.$data
//            .receive(on: RunLoop.main)
//            .sink { newData in
//                self.data.append(contentsOf: newData)
//            }
//            .store(in: &cancellables)
    }
}

struct AsyncPublisherBootcamp: View {
    @StateObject var vm = AsyncPublisherBootcampViewModel()
    
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
            await vm.start()
        }
    }
}

struct AsyncPublisherBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AsyncPublisherBootcamp()
    }
}
