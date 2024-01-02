//
//  SelectMultiplePhotos.swift
//  PhotoPicker-SwiftUI
//
//  Created by 贾建辉 on 2024/1/2.
//

import SwiftUI
import PhotosUI

struct SelectMultiplePhotos: View {
    
    @State var selectedItem: PhotosPickerItem? //单选
    
    @State var selectedItems: [PhotosPickerItem] = []  //多选
    
    var body: some View {
        VStack(spacing: 30) {
            
            
            PhotosPicker(selection: $selectedItems, matching: .images) {  //匹配所有图片
                Image(systemName: "heart.fill")
                Text("SelectMultiplePhotos")
            }
            
            PhotosPicker(selection: $selectedItem,
                         matching: .all(of: [.images, .not(.screenshots)])  //匹配所有图片，排除截屏
            ) {
                Text("SelectSinglePhoto")
            }
            
            PhotosPicker("picker", selection: $selectedItems, matching: .images, preferredItemEncoding: .current)
        }
        .buttonStyle(.bordered)
    }
}

struct SelectMultiplePhotos_Previews: PreviewProvider {
    static var previews: some View {
        SelectMultiplePhotos()
    }
}
