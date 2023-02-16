//
// DependencyInjectionBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import SwiftUI
import Combine

// Problems with singelton
// 1. Singeltons are Global.
// 2. Can not customize init.
// 3. Can not swap service.

struct PostsModel: Decodable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}

protocol DataService {
    func getData() -> AnyPublisher<[PostsModel], Error>
}

class ProductionDataService: DataService {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class MockDataService: DataService {
    let testData = [
        PostsModel(id: 1, userId: 1, title: "Title 1", body: "Body 1"),
        PostsModel(id: 2, userId: 2, title: "Title 2", body: "Body 2")
    ]

    func getData() -> AnyPublisher<[PostsModel], Error> {
        Just(testData)
            .tryMap { $0 }
            .eraseToAnyPublisher()
    }
}

class Dependencies {
    let mockService: MockDataService
    let prodService: ProductionDataService
    
    init(mockService: MockDataService, prodService: ProductionDataService) {
        self.mockService = mockService
        self.prodService = prodService
    }
}

class DependencyInjectionViewModel: ObservableObject {
    @Published var data: [PostsModel] = []
    private var cancellables = Set<AnyCancellable>()
    let dataService: DataService
    
    init(dataService: DataService) {
        self.dataService = dataService
        loadPosts()
    }
    
    private func loadPosts() {
        dataService.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] posts in
                self?.data = posts
            }
            .store(in: &cancellables)
    }
}

struct DependencyInjectionBootcamp: View {
    @StateObject private var viewModel: DependencyInjectionViewModel
    
    init(dataService: DataService) {
        _viewModel = StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.data) { post in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(post.id)")
                                .font(.title)
                            
                            Text(post.title)
                        }
                        Divider()
                    }
                    .padding()
                }
            }
        }
    }
}

struct DependencyInjectionBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let prodService = ProductionDataService(url: url)
        let mockService = MockDataService()
        DependencyInjectionBootcamp(dataService: mockService)
    }
}
