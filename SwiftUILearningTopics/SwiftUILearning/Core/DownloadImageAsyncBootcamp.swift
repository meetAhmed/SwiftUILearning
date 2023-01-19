//
// DownloadImageAsyncBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import Combine
import SwiftUI

class DownloadImageAsyncLoader {
    let url = URL(string: "https://picsum.photos/200")!
    
    private func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300,
            let data,
            let image = UIImage(data: data) else { return nil }
        return image
    }
    
    func downloadWithEscaping(completion: @escaping (_ image: UIImage?, _ error:  Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let self {
                let image = self.handleResponse(data: data, response: response)
                completion(image, nil)
            }
        }
        .resume()
    }
    
    func downloadWithCombine() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
    
    func downloadWithAsync() async throws -> UIImage? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            return handleResponse(data: data, response: response)
        } catch {
            throw error
        }
    }
}

class DownloadImageAsyncViewModel: ObservableObject {
    @Published var image: UIImage?
    let downloader = DownloadImageAsyncLoader()
    
    func fetchImage() async {
//        downloader.downloadWithEscaping { [weak self] image, error in
//            if let self, let image {
//                DispatchQueue.main.async {
//                    self.image = image
//                }
//            }
//        }
        
        let image = try? await downloader.downloadWithAsync()
        await MainActor.run {
            self.image = image
        }
    }
}

struct DownloadImageAsyncBootcamp: View {
    @StateObject var vm = DownloadImageAsyncViewModel()
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .onAppear {
            Task {
                await vm.fetchImage()
            }
        }
    }
}

struct DownloadImageAsyncBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadImageAsyncBootcamp()
    }
}
