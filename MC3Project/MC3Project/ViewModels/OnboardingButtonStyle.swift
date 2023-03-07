//
//  OnboardingButtonStyle.swift
//  MC3Project
//
//  Created by Michele D'Ambra on 07/03/23.
//

import Foundation
import SwiftUI

struct OnboardingButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.indigo)
            .cornerRadius(15)
            .scaleEffect(configuration.isPressed ? 1.5 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            
    }
}
