//
//  SwiftUIView.swift
//  MC3Project
//
//  Created by Dolores Pastore on 01/03/23.
//

import SwiftUI

struct LearningView: View {
    let deviceWidth = UIScreen.main.bounds.width
    let deviceHeight = UIScreen.main.bounds.height
    
    var body: some View {
        VStack (spacing: 0) {
            Rectangle().fill(.black)
            Rectangle().fill(.red)
            Rectangle().fill(.orange)
            Rectangle().fill(.yellow)
            Rectangle().fill(.green)
            Rectangle().fill(.blue)
            Rectangle().fill(.indigo)
            Rectangle().fill(.purple)
            Rectangle().fill(.white)
        }
        // .ignoresSafeArea()
    }
}

struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView()
    }
}
