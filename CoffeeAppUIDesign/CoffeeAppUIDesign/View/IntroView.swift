//
//  IntroView.swift
//  CoffeeAppUIDesign
//
//  Created by Ahmed Ali on 30/01/2023.
//

import SwiftUI

struct IntroView: View {
    @AppStorage("signed_in") var currentUserSignedIn = false
    
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [.purple, .blue],
                center: .topLeading,
                startRadius: 5,
                endRadius: UIScreen.main.bounds.height
            )
            .ignoresSafeArea()
            
            if currentUserSignedIn {
                Text("Profile View")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            } else {
                OnboardingView()
            }
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
