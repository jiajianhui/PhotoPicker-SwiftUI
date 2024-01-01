//
//  ContentView.swift
//  PhotoPicker-SwiftUI
//
//  Created by 贾建辉 on 2024/1/1.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @StateObject var imageData = ImageData()
    
    var body: some View {
        NavigationView {
            VStack {
                switch imageData.imageState {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .loading:
                    ProgressView()
                case .empty:
                    Image(systemName: "heart")
                case .failure:
                    Image(systemName: "exclamationmark.triangle.fill")
                }
            }
            .navigationTitle("PhotoPicker")
            .toolbar {
                PhotosPicker(selection: $imageData.selectedImage, matching: .images) {
                    Image(systemName: "plus")
                }

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
