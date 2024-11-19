//
//  ProfileCheckView.swift
//  babya
//
//  Created by hyk on 10/17/24.
//

import SwiftUI
import Kingfisher

struct ProfileCheckView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = ProfileViewModel.shared
    
    var body: some View {
        ScrollView {
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
            } else {
                Image("baseProfile")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .clipShape(Circle())
                    .padding(.vertical, 30)
            }
            
            Group {
                HStack {
                    Text("이름")
                        .font(.system(size: 16, weight: .medium))
                    
                    Spacer()
                    
                    Text(viewModel.model.data.nickname)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color.LabelAlternative)
                }
                .padding(.horizontal, 40)
                
                HStack {
                    Text("지역")
                        .font(.system(size: 16, weight: .medium))
                    
                    Spacer()
                    
                    if let state = PolicyViewModel.shared.selectedState?.name {
                        Text(state)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(Color.LabelAlternative)
                    }
                }
                .padding(.horizontal, 40)
                
                HStack {
                    Text("생년월일")
                        .font(.system(size: 16, weight: .medium))
                    
                    Spacer()
                    
                    Text(viewModel.model.data.birthDt ?? "비공개")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color.LabelAlternative)
                }
                .padding(.horizontal, 40)
                
                HStack {
                    Text("이메일")
                        .font(.system(size: 16, weight: .medium))
                    
                    Spacer()
                    
                    Text(LoginUserHashCache.shared.checkEmail() ?? "오류")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color.LabelAlternative)
                }
                .padding(.horizontal, 40)
                
                Rectangle()
                    .frame(height: 10)
                    .foregroundStyle(Color.ComponentFillAlternative)
                
                HStack {
                    Text("결혼정보")
                        .font(.system(size: 16, weight: .medium))
                    
                    Spacer()
                }
                .padding(.horizontal, 40)
                
                HStack {
                    Text("결혼기념일")
                        .font(.system(size: 16, weight: .medium))
                    
                    Spacer()
                    
                    Text(viewModel.model.data.marriedYears ?? "X")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color.LabelAlternative)
                }
                .padding(.horizontal, 40)
                
            }
            .padding(.vertical, 10)
            
            HStack {
                Text("태명")
                    .font(.system(size: 16, weight: .medium))
                
                Spacer()
                
                if let firstChild = viewModel.model.data.children?.first(where: { $0?.type != "CHILD" }) {
                    Text(firstChild?.name ?? "X")  // Non-CHILD type
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color.LabelAlternative)
                } else {
                    Text("X")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color.LabelAlternative)
                }
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 10)

            HStack {
                Text("아이")
                    .font(.system(size: 16, weight: .medium))
                
                Spacer()
                
                if let firstChild = viewModel.model.data.children?.first(where: { $0?.type == "CHILD" }) {
                    Text(firstChild?.name ?? "X")  // CHILD type
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color.LabelAlternative)
                } else {
                    Text("X")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color.LabelAlternative)
                }
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
        }
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
                Text("\(viewModel.model.data.nickname)님의 정보")
                    .font(.system(size: 16, weight: .medium))
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: ProfileModifyView()) {
                    Text("수정")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Color.LabelAlternative)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            regionConverter(code: "\(viewModel.myRegion.data)")
            viewModel.getMyProfile()
        }
    }
}

#Preview {
    NavigationView {
        ProfileCheckView()
    }
}
