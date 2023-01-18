//
// ActorsBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import SwiftUI

class DataManager {
    static let shared = DataManager()
    private init() {}
    
    var data: [String] = []
    private let queue = DispatchQueue(label: "com.myApp.DataManager")
    nonisolated let randomSavedData = "Saved"
    
    nonisolated func getRandomData(completion: @escaping (_ title: String?) -> Void) {
        queue.async {
            self.data.append(UUID().uuidString)
            completion(self.data.randomElement())
        }
    }
}

actor MyActorDataManager {
    static let shared = MyActorDataManager()
    private init() {}
    
    var data: [String] = []
    
    func getRandomData() -> String? {
        data.append(UUID().uuidString)
        return data.randomElement()
    }
    
    func getSavedData() -> String {
        "Saved Data"
    }
}

struct HomeView: View {
    @State private var text = ""
    let manager = MyActorDataManager.shared
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
            
            Text(text)
                .font(.headline)
        }
        .onReceive(timer) { _ in
            Task {
                if let data = await manager.getRandomData() {
                    await MainActor.run(body: {
                        self.text = data
                    })
                }
            }
//            DispatchQueue.global(qos: .background).async {
//                manager.getRandomData() { data in
//                    if let data {
//                        DispatchQueue.main.async {
//                            self.text = data
//                        }
//                    }
//                }
//            }
        }
    }
}

struct BrowseView: View {
    @State private var text = ""
    let manager = MyActorDataManager.shared
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.green.opacity(0.1)
            
            Text(text)
                .font(.headline)
        }
        .onReceive(timer) { _ in
            Task {
                if let data = await manager.getRandomData() {
                    await MainActor.run(body: {
                        self.text = data
                    })
                }
            }
//            DispatchQueue.global(qos: .background).async {
//                manager.getRandomData() { data in
//                    if let data {
//                        DispatchQueue.main.async {
//                            self.text = data
//                        }
//                    }
//                }
//            }
        }
    }
}

struct ActorsBootcamp: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "magnifyingglass")
                }
        }
    }
}

struct ActorsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ActorsBootcamp()
    }
}
