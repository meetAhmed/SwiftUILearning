//
// HapticsBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import SwiftUI

class HapticsManager {
    static let instance = HapticsManager()
    private init() {}
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct HapticsBootcamp: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("success") { HapticsManager.instance.notification(type: .success) }
            Button("error") { HapticsManager.instance.notification(type: .error) }
            Button("warning") { HapticsManager.instance.notification(type: .warning) }
            Divider()
            Button("soft") { HapticsManager.instance.impact(style: .soft) }
            Button("heavy") { HapticsManager.instance.impact(style: .heavy) }
            Button("light") { HapticsManager.instance.impact(style: .light) }
            Button("medium") { HapticsManager.instance.impact(style: .medium) }
            Button("rigid") { HapticsManager.instance.impact(style: .rigid) }
        }
    }
}

struct HapticsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HapticsBootcamp()
    }
}
