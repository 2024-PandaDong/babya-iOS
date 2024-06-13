//
//  ImagePickerBox.swift
//  babya
//
//  Created by hyk on 6/6/24.
//

import SwiftUI

struct ImagePickerBox: View {
    @StateObject var viewModel = PostingViewModel()
    
    let width: CGFloat
    let height: CGFloat
    
    @State private var showImagePicker = false
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    
    func loadImage() {
        guard let selectedImage = selectedUIImage else { return }
        image = Image(uiImage: selectedImage)
        viewModel.imageUpload(image: selectedImage)
    }
        
    var body: some View {
        VStack {
            if let image = image {
                ZStack {
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack {
                        HStack {
                            Spacer()
                            
                            Button {
                                self.image = nil
                            } label: {
                                Circle()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(.white)
                                    .overlay {
                                        Circle().stroke(.yellow, lineWidth: 1)
                                        
                                        Image(systemName: "xmark")
                                            .foregroundStyle(.yellow)
                                            .font(.system(size: 15))
                                    }
                                    .offset(x: 10, y: -10)
                            }
                        }
                        
                        Spacer()
                    }
                }
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
