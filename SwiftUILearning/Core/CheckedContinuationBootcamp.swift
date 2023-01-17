//
// CheckedContinuationBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import SwiftUI

class CheckedContinuationBootcampDataManager {
    func getData(url: URL) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw error
        }
    }
    
    func getData2(url: URL) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data {
                    continuation.resume(returning: data)
                } else if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: URLError(.badURL))
                }
            }
            .resume()
        }
    }
}

class CheckedContinuationBootcampViewModel: ObservableObject {
    @Published var image: UIImage?
    let manager = CheckedContinuationBootcampDataManager()
    
    func fetchImage() async {
        guard let url = URL(string: "https://picsum.photos/200") else { return }
        do {
            let data = try await manager.getData2(url: url)
            if let image = UIImage(data: data) {
                await MainActor.run(body: {
                    self.image = image
                })
            }
        } catch {
            print("CheckedContinuationBootcampViewModel: \(error)")
        }
    }
}

struct CheckedContinuationBootcamp: View {
    @StateObject var vm = CheckedContinuationBootcampViewModel()
    
    var body: some View {
        VStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            await vm.fetchImage()
        }
    }
}

struct CheckedContinuationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CheckedContinuationBootcamp()
    }
}
