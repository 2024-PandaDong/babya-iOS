//
//  ProfileModifyView.swift
//  babya
//
//  Created by hyk on 10/22/24.
//

import SwiftUI
import Kingfisher

struct ProfileModifyView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = ProfileViewModel.shared
    
    @State private var showImagePicker = false
    @State private var showLocationPicker = false
    @State var selectedUIImage: UIImage?
    
    var body: some View {
        ZStack {
            ScrollView {
                Button {
                    showImagePicker.toggle()
                } label: {
                    ZStack {
                        if let img = viewModel.model.data.profileImg {
                            KFImage(URL(string: img))
                                .placeholder {
                                    ProgressView()
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                        .overlay {
                                            Circle().stroke(Color.LineAlternative)
                                        }
                                }
                                .setProcessor(DownsamplingImageProcessor(size: CGSize(width: 200, height: 200)))
                                .cacheMemoryOnly()
                                .fade(duration: 0.25)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .padding(.vertical, 30)
                        } else if selectedUIImage != nil{
                            Image(uiImage: selectedUIImage ?? .init())
                                .resizable()
                                .frame(width: 100, height: 100)
                                .scaledToFit()
                                .clipShape(Circle())
                                .padding(.vertical, 30)
                        } else {
                            Image("baseProfile")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .scaledToFit()
                                .clipShape(Circle())
                                .padding(.vertical, 30)
                        }
                        
                        Circle()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(.white)
                        .overlay {
                            Circle()
                                .frame(width: 15, height: 15)
                                .foregroundStyle(Color.ComponentMaterialDimmer)
                                .overlay {
                                    Image(systemName: "plus")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 13, weight: .medium))
                                }
                        }
                        .padding(.top, 60)
                        .padding(.leading, 70)
                    }
                }
                .sheet(isPresented: $showImagePicker, onDismiss: {
                    viewModel.imageUpload(image: selectedUIImage ?? .init())
                }) {
                    ImagePicker(image: $selectedUIImage)
                }
                
                Group {
                    HStack {
                        Text("이름")
                            .font(.system(size: 14, weight: .medium))
                        
                        Spacer()
                    }
                    SignUpTextField(content: $viewModel.profileModifyModel.nickName, placeholder: "이름")
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                
                Group {
                    HStack {
                        Text("생년월일")
                            .font(.system(size: 14, weight: .medium))
                        
                        Spacer()
                    }
                    CustomDatePicker(target: $viewModel.profileModifyModel.birthDt, prompt: "생년월일")
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                
                Group {
                    HStack {
                        Text("결혼일")
                            .font(.system(size: 14, weight: .medium))
                        
                        Spacer()
                    }
                    CustomDatePicker(target: $viewModel.profileModifyModel.marriedDt, prompt: "결혼일")
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                
                Group {
                    HStack {
                        Text("임신일")
                            .font(.system(size: 14, weight: .medium))
                        
                        Spacer()
                    }
                    CustomDatePicker(target: $viewModel.profileModifyModel.pregnancyDt, prompt: "임신일")
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                
                Group {
                    HStack {
                        Text("지역")
                            .font(.system(size: 14, weight: .medium))
                        
                        Spacer()
                    }
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(maxWidth: .infinity, minHeight: 55, maxHeight: 55)
                        .foregroundStyle(.white)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.LineAlternative)
                            
                            HStack {
                                Text("\(viewModel.selectedState?.name ?? "") \(viewModel.selectedDistrict)")
                                    .font(.system(size: 16, weight: .semibold))
                                
                                Spacer()
                                
                                Button(action: {
                                    showLocationPicker = true
                                }, label: {
                                    Image(systemName: "map")
                                        .foregroundStyle(Color.LabelDisable)
                                })
                                .padding(.trailing, 10)
                                .sheet(isPresented: $showLocationPicker) {
                                    ProfileLocationView()
                                        .environmentObject(viewModel)
                                }
                                .foregroundStyle(.black)
                            }
                            .padding(.horizontal, 25)
                            .foregroundStyle(Color.LabelDisable)
                        }
                }
                .padding(.horizontal, 20)
                
                Spacer()
                    .frame(height: 70)
                
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.black)
                            .fontWeight(.medium)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("내 정보 수정")
                        .font(.system(size: 16, weight: .medium))
                }
            }
            .toolbarBackground(.white)
            
            VStack {
                Spacer()
                
                Button {
                    if !viewModel.profileImageRequest.imgUrl.isEmpty {
                        viewModel.patchProfileImage()
                        print(viewModel.profileImageRequest.parmas)
                    }
                    
                    viewModel.patchProfile {
                        viewModel.getMyRegion()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 325, height: 45)
                        .foregroundStyle(Color.PrimaryNormal)
                        .overlay {
                            Text("수정완료")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)
                        }
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        ProfileModifyView()
    }
}
