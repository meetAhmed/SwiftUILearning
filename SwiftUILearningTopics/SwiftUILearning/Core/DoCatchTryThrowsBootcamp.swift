//
// DoCatchTryThrowsBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import SwiftUI

// do-catch
// try
// throws

class DoCatchTryThrowsDataManager {
    let isActive = false
    
    func getTitle() -> String {
        "New text"
    }
    
    func getTitle2() throws -> String {
        if isActive {
            return "New text"
        } else {
            throw URLError(.notConnectedToInternet)
        }
    }
}

class DoCatchTryThrowsViewModel: ObservableObject {
    @Published var text = "Starting Text"
    let manager = DoCatchTryThrowsDataManager()
    
    func getTitle() {
        _ = try? manager.getTitle2()
        do {
            let newText = try manager.getTitle2()
            text = newText
        } catch {
            text = error.localizedDescription
        }
    }
}

struct DoCatchTryThrowsBootcamp: View {
    @StateObject private var vm = DoCatchTryThrowsViewModel()
    
    var body: some View {
        Text(vm.text)
            .frame(width: 250, height: 250)
            .background(.blue)
            .onTapGesture {
                vm.getTitle()
            }
    }
}

struct DoCatchTryThrowsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DoCatchTryThrowsBootcamp()
    }
}
