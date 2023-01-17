//
// TaskBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import SwiftUI

class TaskBootcampViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil
    
    func fetchImage() async {
        do {
            try? await Task.sleep(nanoseconds: 5_000_000_000)
            guard let url = URL(string: "https://picsum.photos/200") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            await MainActor.run(body: {
                self.image = UIImage(data: data)
            })
        } catch {
            print("fetchImage: \(error.localizedDescription)")
        }
    }
    
    func fetchImage2() async {
        do {
            guard let url = URL(string: "https://picsum.photos/300") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            await MainActor.run(body: {
                self.image2 = UIImage(data: data)
            })
            
            // long running task
//            for x in someData {
//                // work
//
//                // check if task is cancelled or not
//                try Task.checkCancellation()
//            }
        } catch {
            print("fetchImage2: \(error.localizedDescription)")
        }
    }
}

struct TaskBootcampHomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink("Go to Task Bootcamp", destination: TaskBootcamp())
            }
        }
    }
}

struct TaskBootcamp: View {
    @StateObject var vm = TaskBootcampViewModel()
    @State private var fetchImageTask: Task<(), Never>?
    
    var body: some View {
        VStack(spacing: 40) {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            
            if let image = vm.image2 {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            await vm.fetchImage()
        }
//        .onDisappear {
//            fetchImageTask?.cancel()
//        }
//        .onAppear {
//            fetchImageTask = Task {
//                await vm.fetchImage()
//            }
//            Task {
//                await vm.fetchImage2()
//            }
//
//            Task(priority: .high) {
//                print("high: \(Task.currentPriority)")
//            }
//
//            Task(priority: .userInitiated) {
//                print("userInitiated: \(Task.currentPriority)")
//            }
//
//            Task(priority: .medium) {
//                print("medium: \(Task.currentPriority)")
//            }
//
//            Task(priority: .low) {
//                print("low: \(Task.currentPriority)")
//            }
//
//            Task(priority: .utility) {
//                print("utility: \(Task.currentPriority)")
//            }
//
//            Task(priority: .background) {
//                print("background: \(Task.currentPriority)")
//            }
//
//            Task(priority: .userInitiated) {
//                print("userInitiated: \(Task.currentPriority)")
//
//                Task.detached {
//                    print("detached: \(Task.currentPriority)")
//                }
//            }
//        }
    }
}

struct TaskBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TaskBootcamp()
    }
}
