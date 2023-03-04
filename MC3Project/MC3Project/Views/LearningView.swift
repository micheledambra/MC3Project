//
//  SwiftUIView.swift
//  MC3Project
//
//  Created by Dolores Pastore on 01/03/23.
//

import SwiftUI

struct LearningView: View {
    
    var body: some View {
        VStack (spacing: 0) {
            Rectangle().fill(.black)
            Rectangle().fill(.white)
            Rectangle().fill(.red)
            Rectangle().fill(.orange)
            Rectangle().fill(.yellow)
            Rectangle().fill(.green)
            Rectangle().fill(.blue)
            Rectangle().fill(.indigo)
            Rectangle().fill(.purple)
        }
        // .ignoresSafeArea()
    }
}

struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView()
    }
}
