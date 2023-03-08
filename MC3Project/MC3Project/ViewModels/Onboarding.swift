//
//  Onboarding.swift
//  MC3Project
//
//  Created by Beatriz Gomes on 28/02/23.
//

import SwiftUI

struct Onboarding: View {
    @Binding var shouldShowOnboarding: Bool
    
    var body: some View {
        TabView {
            PageView(
                title: "Feel the Colors",
                subtitle: "Select a picture from your Photo Library and be ready to perceive colors. Once you're done listening, just shake your phone.",
                //AnimatedWave()
                //imageName: "paintpalette")
                showsDismissButton: false,
                shouldShowOnboarding: $shouldShowOnboarding)
            
            PageView(
                title: "Learn Colors",
                subtitle: "Tap on each color to listen again and learn their sound.",
                //AnimatedWave()
                //imageName: "ear.and.waveform")
                showsDismissButton: true,
                shouldShowOnboarding: $shouldShowOnboarding)
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
    
}

struct PageView: View {
    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey
    //let imageName: String
    let showsDismissButton: Bool
    @Binding var shouldShowOnboarding: Bool
    
    var body: some View {
        ZStack {
            AnimatedWave()
            VStack{
                //AnimatedWave()
                //Image(systemName: imageName)
                // .resizable()
                //.aspectRatio(contentMode: .fit)
                //.frame(width: 390, height: 390)
                // .padding()
                Text(title)
                    .font(.system(size:32))
                    .foregroundColor(.indigo)
                    .padding()
                
                Text(subtitle)
                    .font(.system(size:24))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding()
                
                if showsDismissButton{
                    Button(action: {
                        shouldShowOnboarding.toggle()
                    }, label: {
                        Text ("Get Started")
                            .font(.headline)
                            .foregroundColor(.white)
                            /*.padding()
                            .background(Color.indigo)
                            .cornerRadius(10)*/
                        
                    }).buttonStyle(OnboardingButtonStyle())
                }
            }
        }
    }
}



