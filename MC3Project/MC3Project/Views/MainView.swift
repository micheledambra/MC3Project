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
        
        NavigationView {
            ZStack {
                BubbleAnimation()
                    .ignoresSafeArea()
                VStack{
                    //TODO: Maybe remove? Do we want to keep this?
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
                    PhotosPicker(selection: $selectedItem,
                                 matching: .any(of: [.images, .not(.livePhotos)])) {
                        Label("Choose from Library", systemImage: "photo")
                    }
                     .controlSize (.large)
                     .buttonStyle(.borderedProminent)
                     .onChange(of: selectedItem) { newItem in
                         selectedItem = newItem
                         loadImage()
                     }

                    Text("OR")
                        .padding()

                    Button {  } label: {
                        Image(systemName: "square.and.arrow.down")
                        Text("Download/Select from API")
                    }
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
        }


    }

    func loadImage() {
        if let selectedItem = selectedItem {
            selectedItem.loadTransferable(type: Data.self) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        selectedPhotoData = data
                        isSheet = true
                    case .failure(let error):
                        // TODO: Proper error handling (show alert that loading the image was not possible)
                        print(error)
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
