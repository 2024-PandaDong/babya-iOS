//
//  NoticeBoardDetailView.swift
//  babya
//
//  Created by hyk on 6/4/24.
//

import SwiftUI

struct NoticeBoardDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @FocusState private var isFocused: Bool
    @StateObject var viewModel = NoticeBoardDetailViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                HStack(spacing: 10) {
                    Circle()
                        .frame(width: 45, height: 45)
                    
                    VStack(spacing: 3) {
                        HStack {
                            Text(viewModel.model.data.postVO.post.title)
                                .font(.system(size: 16, weight: .bold))
                            Button {
                                
                            } label: {
                                Image(systemName: "star")
                                    .font(.system(size: 15))
                                    .foregroundStyle(.black)
                            }
                            
                            Spacer()
                            
                            //
                        }
                        
                        HStack {
                            Image(systemName: "eye.fill")
                                .foregroundStyle(.gray)
                            
                            Text("\(viewModel.model.data.postVO.post.view)")
                            
                            Image(systemName: "bubble")
                                .foregroundStyle(.gray)
                            
                            Text("")
                            
                            Spacer()
                        }
                        .font(.system(size: 15))
                    }
                }
                .padding(.horizontal, 20)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 370, height: 240)
                
                HStack {
                    Text(viewModel.model.data.postVO.post.content)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                HStack {
                    Spacer()
                    
                    Text("30분 전")
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                        .padding(.top)
                        .padding(.horizontal, 20)
                }
                
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: 1)
                    .foregroundStyle(.gray)
                    .padding(.vertical, 10)

                ForEach(0..<$viewModel.model.data.comments.count, id: \.self) { index in
                    CommentCell(name: $viewModel.model.data.comments[index].member.nickName, day: $viewModel.model.data.postVO.post.createdAt, content: $viewModel.model.data.comments[index].content)
                }
            }
            
            VStack(spacing: 0) {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray)

                HStack(spacing: 0) {
                    Circle()
                        .frame(width: 30, height: 30)
                        .padding(.horizontal, 10)
                    
                    TextField(text: .constant(""), prompt: Text("댓글 쓰기")) {
                        
                    }
                    .frame(height: 45)
                    .focused($isFocused)
                    
                    Button {
                        isFocused = false
                    } label: {
                        Rectangle()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.yellow)
                            .overlay {
                                Image(systemName: "paperplane")
                                    .foregroundStyle(.white)
                            }
                    }
                }
      
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.black)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text(viewModel.model.data.postVO.post.title)
                    .font(.system(size: 20, weight: .bold))
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationView {
        NoticeBoardDetailView()
    }
}
