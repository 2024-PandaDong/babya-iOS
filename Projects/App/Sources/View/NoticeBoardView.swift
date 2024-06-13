//
//  NoticeBoardView.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI

struct NoticeBoardView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = NoticeBoardDetailViewModel()
    
    var body: some View {
        ZStack {
                ScrollView {
                    Rectangle()
                        .frame(height: 110)
                        .foregroundStyle(Color(red: 255/255, green: 203/255, blue: 41/255))
                        .overlay {
                            HStack(spacing: 40) {
                                Text("오늘도 따뜻한 가정을 위해\n애기야에서 이야기 나눠봐요")
                                    .font(.system(size: 20, weight: .bold))
                                
                                Image("duck")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .offset(x: 0, y: 15)
                            }
                        }
                    
                    ForEach(0..<viewModel.model.data.comments.count, id: \.self) { index in
                        PostPreviewCell(model: viewModel.model)
                    }
                    
                    Spacer()
                        .frame(height: 100)
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
                    Text("게시판")
                        .font(.system(size: 20, weight: .bold))
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .foregroundStyle(.black)
                            .font(.system(size: 15))
                    }
                }
            }
            
            VStack {
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    NavigationLink(destination: PostingView()) {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(Color(red: 255/255, green: 203/255, blue: 41/255))
                            .overlay {
                                Image(systemName: "pencil")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 25))
                            }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 30)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationView {
        NoticeBoardView()
    }
}
