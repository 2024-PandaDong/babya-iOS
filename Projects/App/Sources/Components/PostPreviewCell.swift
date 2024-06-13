//
//  PostPreviewCell.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI

struct PostPreviewCell: View {
    @StateObject var viewModel = NoticeBoardViewModel()
    
    var body: some View {
        NavigationLink(destination: NoticeBoardDetailView()) {
            VStack(spacing: 0) {
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: 130)
                    .foregroundStyle(.white)
                    .overlay {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("박규민")
                                    .font(.system(size: 16, weight: .bold))
                                
                                Spacer()
                                
                                Text("동동이맘")
                                    .font(.system(size: 12, weight: .bold))
                                
                                Circle()
                                    .frame(width: 18, height: 18)
                            }
                            .padding(.horizontal, 20)
                            
                            Text("오늘부터 4주차 동동이 엄마 입니다. \n임신한 후에 모임 가지면서 요가 같이 해봐요~")
                                .font(.system(size: 14))
                                .foregroundStyle(.gray)
                                .padding(.horizontal, 20)
                            
                            Spacer()
                            
                            HStack {
                                Capsule()
                                    .frame(width: 50, height: 15)
                                    .foregroundStyle(.white)
                                    .overlay {
                                        Capsule().stroke(.gray)
                                        
                                        HStack {
                                            Image(systemName: "eye.fill")
                                                .font(.system(size: 10))
                                            
                                            Text("154")
                                                .font(.system(size: 10))
                                        }
                                    }
                                
                                Capsule()
                                    .frame(width: 50, height: 15)
                                    .foregroundStyle(.white)
                                    .overlay {
                                        Capsule().stroke(.gray)
                                        
                                        HStack {
                                            Image(systemName: "bubble")
                                                .font(.system(size: 10))
                                            
                                            Text("12")
                                                .font(.system(size: 10))
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
                
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: 1)
                    .foregroundStyle(.gray)
            }
            .tint(.black)
        }
    }
}

#Preview {
    NavigationView {
        ZStack {
            Color.black
            
            PostPreviewCell()
        }
    }
}
