//
// SendableBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import SwiftUI

actor CurrentUserManager {
    func updateDatabase(info: MyUserInfo) {
        
    }
}

struct MyUserInfo: Sendable {
    let name: String
}

class SendableBootcampViewModel: ObservableObject {
    let manager = CurrentUserManager()
    
    func updateCurrentUserInfo() async {
        let info = MyUserInfo(name: "Test User")
        await manager.updateDatabase(info: info)
    }
}

struct SendableBootcamp: View {
    @StateObject var vm = SendableBootcampViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SendableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SendableBootcamp()
    }
}
