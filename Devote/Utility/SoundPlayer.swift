//
//  SoundPlayer.swift
//  Devote
//
//  Created by Jack Pyo Toke on 20/10/21.
//

import AVFoundation
import Foundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        }
        catch {
            print("Could not find and play the given sound file.")
        }
    }
}
