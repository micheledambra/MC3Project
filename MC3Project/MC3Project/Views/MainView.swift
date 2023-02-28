//
//  MainView.swift
//  MC3Project
//
//  Created by Beatriz Gomes on 24/02/23.
//

import SwiftUI
import PhotosUI

struct MainView: View {
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedPhotoData: Data?
    @State private var isSheet = false
    
    
    var body: some View {
        
        NavigationView{
            ZStack {
               BubbleAnimation()
                
                
                VStack{
                    
                    if let selectedPhotoData,
                       let uiImage = UIImage(data: selectedPhotoData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                            .onTapGesture {
                                isSheet = true
                            }
                    }
                    
                    PhotosPicker (selection: $selectedItem,
                                  matching: .any(of: [.images, .not(.livePhotos)])) {
                        Label("Choose from Library", systemImage: "photo")
                    }
                                  .controlSize (.large)
                                  .buttonStyle(.borderedProminent)
                                  .onChange(of: selectedItem) { newItem in
                                      Task{ @MainActor in
                                          if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                              selectedPhotoData = data
                                          }
                                      }
                                      //isSheet = true
                                      
                                  }
                    
                    
                    Text("OR")
                        .padding()
                    
                    Button {  } label: {
                        Image(systemName: "square.and.arrow.down")
                        Text("Download/ Select from API") }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .contentShape(Rectangle())
                    .padding()
                    
                    
                }
                .navigationBarTitle("Home??")
                .fullScreenCover(isPresented: $isSheet) {
                    SensationView(imageData: selectedPhotoData)
                }
                
            }
            .ignoresSafeArea()
            
        }//zstack
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
