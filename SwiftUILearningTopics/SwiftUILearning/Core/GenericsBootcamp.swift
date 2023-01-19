//
// GenericsBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import SwiftUI

struct GenericModel<T> {
    let info: T?
    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
    }
}

class GenericsViewModel: ObservableObject {
    @Published var genericStringModel = GenericModel(info: "Hello")
    @Published var genericBoolModel = GenericModel(info: false)
    
    func removeData() {
        genericStringModel = genericStringModel.removeInfo()
        genericBoolModel = genericBoolModel.removeInfo()
    }
}

struct GenericView<T: View>: View {
    let title: String
    let content: T
    
    var body: some View {
        VStack {
            Text(title)
            content
        }
    }
}

struct GenericsBootcamp: View {
    @StateObject var vm = GenericsViewModel()
    
    var body: some View {
        VStack {
            Text("String: \(vm.genericStringModel.info ?? "No data")")
            Text("Bool: \(vm.genericBoolModel.info?.description ?? "No data")")
            GenericView(title: "Generic View", content: Text("Content"))
        }
        .onTapGesture {
            vm.removeData()
        }
    }
}

struct GenericsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GenericsBootcamp()
    }
}
