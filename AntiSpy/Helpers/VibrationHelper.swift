//
//  VibrationHelper.swift
//  AntiSpy
//
//  Created by Rome on 4/23/23.
//

import Foundation
import SwiftUI

func makeVibration(){
    // Create a UIImpactFeedbackGenerator instance
    let generator = UIImpactFeedbackGenerator(style: .heavy)

    // Prepare the generator (optional)
    generator.prepare()

    // Trigger the generator to emit the vibration
    generator.impactOccurred()
}
