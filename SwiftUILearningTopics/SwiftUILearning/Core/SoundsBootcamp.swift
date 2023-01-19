//
// SoundsBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import AVKit
import SwiftUI

class SoundsManager {
    static let instance = SoundsManager()
    private init() {}
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case tada, badum
    }
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error: SoundsManager: \(error)")
        }
    }
}

struct SoundsBootcamp: View {
    private var soundManager = SoundsManager.instance
    
    var body: some View {
        VStack(spacing: 40) {
            Button("Play sound") {
                soundManager.playSound(sound: .tada)
            }
            
            Button("Play sound 2") {
                soundManager.playSound(sound: .badum)
            }
        }
    }
}

struct SoundsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SoundsBootcamp()
    }
}
