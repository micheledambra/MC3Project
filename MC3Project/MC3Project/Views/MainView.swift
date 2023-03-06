//
//  MainView.swift
//  MC3Project
//
//  Created by Beatriz Gomes on 24/02/23.
//

import SwiftUI
import PhotosUI

struct MainView: View {

    @State private var sensationView = SensationView()

    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedPhotoData: Data?
    @State private var isSheet = false
    
    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true

    var body: some View {
        
        NavigationView {
            ZStack {
                BubbleAnimation2()
                    .ignoresSafeArea()
                VStack{
                    if let selectedPhotoData = selectedPhotoData{
                        Image(uiImage: (UIImage(data: selectedPhotoData) ?? UIImage(systemName: "x.square"))!)
                            .resizable()
                            .frame(width: 0, height: 0)
                    }
                    PhotosPicker(selection: $selectedItem,
                                 matching: .any(of: [.images, .not(.livePhotos)])) {
                        Label("Choose from Library", systemImage: "photo")
                            .bold()
                            .foregroundColor(.white)
                            
                    }.buttonStyle(MainViewButton())
                                // .controlSize (.large)
                               //  .buttonStyle(.borderedProminent)
                    
                                 .onChange(of: selectedItem) { newItem in
                                     selectedItem = newItem
                                     Task{
                                         await loadImage()
                                     }
                                 }

                    Text("Or")
                        .padding(22)
                        .bold()

                    Button {  } label: {
                        Image(systemName: "square.and.arrow.down")
                        Text("Download/Select from API")
                            .bold()
                    }
                    .buttonStyle(.borderedProminent)
                    //.background("ButtonColor")
                    .controlSize(.large)
                    .contentShape(Rectangle())
                    
                }
                .fullScreenCover(isPresented: $isSheet) {
                    SensationView(imageData: selectedPhotoData)
                }
            }
        .fullScreenCover(isPresented: $shouldShowOnboarding, content: {
            OnboardingView(shouldShowOnboarding: $shouldShowOnboarding)
})

        }


    }

    @MainActor
    func loadImage() async {
        if let selectedItem = selectedItem {
            do {
                let result = try await selectedItem.loadTransferable(type: Data.self)
                if let result = result {
                    self.selectedPhotoData = result
                    isSheet = true
                }else {
                    print("Extracting data from image not possible")
                }
            } catch {
                print(error)
            }

        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
