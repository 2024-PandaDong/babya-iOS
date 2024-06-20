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
                            Text("")
                                .font(.system(size: 16, weight: .bold))
                            Button {
                                // Button action here
                            } label: {
                                Image(systemName: "star")
                                    .font(.system(size: 15))
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                        }
                        
                        HStack {
                            Image(systemName: "eye.fill")
                                .foregroundColor(.gray)
                            
                            Text("")
                            
                            Image(systemName: "bubble")
                                .foregroundColor(.gray)
                            
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
                    Text("")
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                HStack {
                    Spacer()
                    
                    Text("")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .padding(.top)
                        .padding(.horizontal, 20)
                }
                
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: 1)
                    .foregroundColor(.gray)
                    .padding(.vertical, 10)

//                ForEach(viewModel.model.data.comments.indices, id: \.self) { index in
//                    CommentCell(name: viewModel.model.data.comments[index].member.nickName,
//                                day: viewModel.model.data.comments[index].createdAt,
//                                content: viewModel.model.data.comments[index].content)
//                }
            }
            
            VStack(spacing: 0) {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)

                HStack(spacing: 0) {
                    Circle()
                        .frame(width: 30, height: 30)
                        .padding(.horizontal, 10)
                    
                    TextField("댓글 쓰기", text: .constant(""))
                        .frame(height: 45)
                        .focused($isFocused)
                    
                    Button {
                        isFocused = false
                        // Add comment action here
                    } label: {
                        Rectangle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.yellow)
                            .overlay {
                                Image(systemName: "paperplane")
                                    .foregroundColor(.white)
                            }
                    }
                }
      
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("")
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
