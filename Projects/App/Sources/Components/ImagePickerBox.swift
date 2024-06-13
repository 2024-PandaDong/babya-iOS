//
//  ImagePickerBox.swift
//  babya
//
//  Created by hyk on 6/6/24.
//

import SwiftUI

struct ImagePickerBox: View {
    let width: CGFloat
    let height: CGFloat
    
    @Binding var target: String
    
    @State private var showImagePicker = false
    @State private var selectedUIImage: UIImage?
    @State private var image: UIImage = UIImage()
        
    func loadImage() {
        guard let selectedImage = selectedUIImage else { return }
        self.image = selectedImage
        target = image.pngData()?.base64EncodedString() ?? ""
    }
    
    var body: some View {
        VStack {
            if let data = Data(base64Encoded: target, options: .ignoreUnknownCharacters),
               let decodedImg = UIImage(data: data) {
                Image(uiImage: decodedImg)
                    .resizable()
                    .frame(width: 340, height: 230)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Button {
                    showImagePicker.toggle()
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: width, height: height)
                        .foregroundColor(.white)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 2)
                            
                            Image(systemName: "photo.badge.plus")
                                .foregroundColor(.black)
                                .font(.system(size: 20))
                        }
                }
                .sheet(isPresented: $showImagePicker, onDismiss: {
                    loadImage()
                }) {
                    ImagePicker(image: $selectedUIImage)
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        PostingView()
    }
}
