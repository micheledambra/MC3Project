//
//  ContentView.swift
//  MC3Project
//
//  Created by Simon Bestler on 23.02.23.
//

import SwiftUI

struct ContentView: View {
    init() {
            UITabBar.appearance().backgroundColor = UIColor.systemBackground
        }
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("Feel", systemImage: "dot.circle.and.hand.point.up.left.fill")
                }
            /*VolumeRGBTestView()
                .tabItem {
                    Label("Sound", systemImage: "ear.and.waveform")
                }*/
            LearningView2()
                .tabItem {
                    Label("Colors", systemImage: "paintpalette")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
