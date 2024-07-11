//
//  NoticeBoardDetailView.swift
//  babya
//
//  Created by hyk on 6/4/24.
//

import SwiftUI

struct NoticeBoardDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.refresh) private var refresh
    @FocusState private var isFocused: Bool
    @StateObject var viewModel = NoticeBoardDetailViewModel()
    let postId: Int
    
    var body: some View {
        VStack {
            ScrollView {
                HStack(spacing: 10) {
                    Circle()
                        .frame(width: 45, height: 45)
                        .overlay {
                            Image("baseProfile")
                                .resizable()
                                .scaledToFit()
                        }
                    
                    VStack(spacing: 3) {
                        HStack {
                            Text(viewModel.model.data.nickname)
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
                            
                            Text("\(viewModel.model.data.view)")
                            
                            Image(systemName: "bubble")
                                .foregroundColor(.gray)
                            
                            Text("\(viewModel.model.data.commentCnt)")
                            
                            Spacer()
                        }
                        .font(.system(size: 15))
                    }
                }
                .padding(.horizontal, 20)
                
                if let fileURLString = viewModel.model.data.files?.first?.url, let fileURL = URL(string: fileURLString) {
                        AsyncImage(url: fileURL) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 240)
                    }
                
                HStack {
                    Text(viewModel.model.data.content)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                HStack {
                    Spacer()
                    
                    Text(viewModel.model.data.createdAt.prefix(10))
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .padding(.top)
                        .padding(.horizontal, 20)
                }
                
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: 1)
                    .foregroundColor(.gray)
                    .padding(.vertical, 10)

                ForEach(0..<viewModel.commentResponse.data.count, id: \.self) { index in
                    CommentCell(model: viewModel.commentResponse, index: index)
                }
            }
            
            VStack(spacing: 0) {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)

                HStack(spacing: 0) {
                    Circle()
                        .frame(width: 30, height: 30)
                        .padding(.horizontal, 10)
                        .overlay {
                            Image("baseProfile")
                                .resizable()
                                .scaledToFit()
                        }
                    
                    TextField("댓글 쓰기", text: $viewModel.commentModel.comment)
                        .frame(height: 45)
                        .focused($isFocused)
                    
                    Button {
                        isFocused = false
                        viewModel.postComment(postId: postId)
                        viewModel.commentModel.comment = ""
                        Task {
                            await refresh?()
                        }
                    } label: {
                        Rectangle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(viewModel.commentModel.comment == "" ? .gray : .yellow0)
                            .overlay {
                                Image(systemName: "paperplane")
                                    .foregroundColor(.white)
                            }
                    }
                    .disabled(viewModel.commentModel.comment == "" ? true : false)
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
                Text(viewModel.model.data.title)
                    .font(.system(size: 20, weight: .bold))
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.getPostDetail(postId: postId)
            viewModel.getComment(page: 1, size: 10, postId: postId)
        }
        .refreshable {
            viewModel.getPostDetail(postId: postId)
            viewModel.getComment(page: 1, size: 10, postId: postId)
        }
    }
}
#Preview {
    NavigationView {
        NoticeBoardDetailView(postId: 1)
    }
}
