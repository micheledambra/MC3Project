//
//  ButtonStyleModel.swift
//  MC3Project
//
//  Created by Michele D'Ambra on 06/03/23.
//

import Foundation
import SwiftUI

struct MainViewButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
         
            .padding(20)
            .controlSize(.large)
            .background(Color("ButtonAccent"))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
        
    }
}
