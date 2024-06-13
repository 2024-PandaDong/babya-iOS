//
//  PostPreviewCell.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI

struct PostPreviewCell: View {
    let model: NoticeBoardDetailModel
    
    var body: some View {
        NavigationLink(destination: NoticeBoardDetailView()) {
            VStack(spacing: 0) {
                Rectangle()
                    .frame(height: 130)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .overlay {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(model.data.postVO.post.title)
                                    .font(.system(size: 16, weight: .bold))
                                
                                Spacer()
                                
                                Text(model.data.postVO.post.member.nickName)
                                    .font(.system(size: 12, weight: .bold))
                                
                                Circle()
                                    .frame(width: 18, height: 18)
                            }
                            .padding(.horizontal, 20)
                            
                            Text(model.data.postVO.post.content)
                                .font(.system(size: 14))
                                .foregroundStyle(.gray)
                                .padding(.horizontal, 20)
                            
                            Spacer()
                            
                            HStack {
                                Capsule()
                                    .frame(width: 50, height: 18)
                                    .foregroundStyle(.white)
                                    .overlay {
                                        ZStack {
                                            Capsule().stroke(.gray)
                                            
                                            HStack {
                                                Image(systemName: "eye.fill")
                                                    .font(.system(size: 12))
                                                
                                                Text("\(model.data.postVO.post.view)")
                                                    .font(.system(size: 12))
                                            }
                                        }
                                    }
                                
                                Capsule()
                                    .frame(width: 50, height: 18)
                                    .foregroundStyle(.white)
                                    .overlay {
                                        ZStack {
                                            Capsule().stroke(.gray)
                                            
                                            HStack {
                                                Image(systemName: "bubble")
                                                    .font(.system(size: 12))
                                                
                                                Text("\(model.data.comments.count)")
                                                    .font(.system(size: 10))
                                            }
                                        }
                                    }
                                
                                Spacer()
                                
                                Text("30분 전")
                                    .font(.system(size: 12))
                                    .foregroundStyle(.gray)
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.vertical, 15)
                    }
                    .tint(.black)
                
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    NavigationView {
        ZStack {
            Color.black
            
            PostPreviewCell(model: NoticeBoardDetailModel())
        }
    }
}
