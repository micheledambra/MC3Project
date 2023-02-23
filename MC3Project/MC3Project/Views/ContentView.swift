//
//  ContentView.swift
//  MC3Project
//
//  Created by Simon Bestler on 23.02.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SensationView()
                .tabItem {
                    Label("Color", systemImage: "photo.artframe")
                }
            VolumeRGBTestView()
                .tabItem {
                    Label("Sound", systemImage: "ear.and.waveform")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
