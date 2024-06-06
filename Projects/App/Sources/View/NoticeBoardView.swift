//
//  NoticeBoardView.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI

struct NoticeBoardView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
                ScrollView {
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width, height: 110)
                    
                    PostPreviewCell()
                    PostPreviewCell()
                    PostPreviewCell()
                    PostPreviewCell()
                    PostPreviewCell()
                    PostPreviewCell()
                    PostPreviewCell()
                    PostPreviewCell()
                    
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
                    .padding(.vertical, 90)
                    .padding(.horizontal, 20)
                }
            }
            
            CustomTabBar()
        }
    }
}

#Preview {
    NavigationView {
        NoticeBoardView()
    }
}
