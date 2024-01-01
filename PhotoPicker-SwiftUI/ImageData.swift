//
//  ImageData.swift
//  PhotoPicker-SwiftUI
//
//  Created by 贾建辉 on 2024/1/1.
//

// 导入必要的框架
import SwiftUI
import PhotosUI


class ImageData: ObservableObject {
    
    //定义图片的状态
    enum ImageState {
        case empty
        case loading(Progress)
        case success(Image)
        case failure(Error)
    }
    
    enum TransferError: Error {
        case importFailed
    }
    
    //创建SelectedImage模型，处理图像 DataRepresentation 的加载，并将其转换为 UIImage 或 NSImage
    struct SelectedImage: Transferable {
        let image: Image
        
        static var transferRepresentation: some TransferRepresentation {
            DataRepresentation(importedContentType: .image) { data in
                guard let uiImage = UIImage(data: data) else {
                    throw TransferError.importFailed
                }
                let image = Image(uiImage: uiImage)
                return SelectedImage(image: image)  //将转换后的数据return出去
            }
        }
        
    }

    
    @Published private(set) var imageState: ImageState = .empty  //默认数据
    
    @Published var selectedImage: PhotosPickerItem? = nil {
        didSet {
            if let selectedImage {
                let progress = loadTransferable(from: selectedImage)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    
    
    
    func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: SelectedImage.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.selectedImage else {
                    print("选择图片失败")
                    return
                }

                switch result {
                case .success(let selectedImage?):
                    self.imageState = .success(selectedImage.image)
                case .success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
}
