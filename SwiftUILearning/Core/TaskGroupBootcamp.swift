//
// TaskGroupBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import SwiftUI

class TaskGroupBootcampDataManager {
    func fetchImagesWithTaskGroup() async throws -> [UIImage] {
        let urlStrings = [
            "https://picsum.photos/200",
            "https://picsum.photos/300",
            "https://picsum.photos/200",
            "https://picsum.photos/200",
            "https://picsum.photos/200",
            "https://picsum.photos/200"
        ]
        return try await withThrowingTaskGroup(of: UIImage?.self) { group in
            var images: [UIImage] = []
            images.reserveCapacity(urlStrings.count)
            
            for urlString in urlStrings {
                group.addTask {
                    try? await self.fetchImage(urlString: urlString)
                }
            }
            
            for try await image in group {
                if let image {
                    images.append(image)
                }
            }
            
            return images
        }
    }
    
    private func fetchImage(urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
        } catch {
            throw error
        }
    }
}

class TaskGroupBootcampViewModel: ObservableObject {
    @Published var images: [UIImage] = []
    let manager = TaskGroupBootcampDataManager()
    
    func getImages() async {
        if let fetchedImages = try? await manager.fetchImagesWithTaskGroup() {
            await MainActor.run(body: {
                self.images.append(contentsOf: fetchedImages)
            })
        }
    }
}

struct TaskGroupBootcamp: View {
    @StateObject var vm = TaskGroupBootcampViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(vm.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                }
            }
            .navigationTitle("Task Group")
            .task {
                await vm.getImages()
            }
        }
    }
}

struct TaskGroupBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TaskGroupBootcamp()
    }
}
