//
//  Onboarding.swift
//  MC3Project
//
//  Created by Beatriz Gomes on 28/02/23.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
    @Binding var shouldShowOnboarding: Bool

    var body: some View {
        TabView {
            PageView(
                title: "Feel colors",
                subtitle: "Select pictures from your Library and hear their colors",
                imageName: "paintpalette",
                showsDismissButton: false,
                shouldShowOnboarding: $shouldShowOnboarding)
            
            PageView(
                title: "Learn colors",
                subtitle: "Listen to the existing color frequencies in the Learning section whenever you want",
                imageName: "ear.and.waveform",
                showsDismissButton: true,
                shouldShowOnboarding: $shouldShowOnboarding)


        }
        .tabViewStyle(PageTabViewStyle())
    }
    
}

struct PageView: View {
    let title: String
    let subtitle: String
    let imageName: String
    let showsDismissButton: Bool
    @Binding var shouldShowOnboarding: Bool
    
    var body: some View {
        VStack{
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .padding()
            
            Text(title)
                .font(.system(size:32))
                .padding()
            
            Text(subtitle)
                .font(.system(size:24))
                .foregroundColor(Color(.secondaryLabel))
                .multilineTextAlignment(.center)
                .padding()
            
            if showsDismissButton{
                Button(action: {
                    shouldShowOnboarding.toggle()
                }, label: {
                    Text("Get Started")
                        .bold()
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .cornerRadius(6)
                })

            }
        }
    }
}
