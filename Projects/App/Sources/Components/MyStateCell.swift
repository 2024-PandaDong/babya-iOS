//
//  MyStateCell.swift
//  babya
//
//  Created by dgsw8th32 on 5/28/24.
//

import SwiftUI

struct MyStateCell: View {
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        HStack() {
            Text("나의 상태")
                .font(.system(size: 16, weight: .black))
            
            Spacer()
        }
        .padding(.horizontal, 20)
        
        TabView {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 360, height: 130)
                .foregroundStyle(.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1)
                    
                    HStack {
                        VStack {
                            Circle()
                                .frame(width: 45, height: 45)
                            
                            Text("좋음")
                                .font(.system(size: 15))
                        }
                        .padding(.horizontal, 30)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("이번 주 박규민 님의 상태는 좋음 입니다.")
                                .font(.system(size: 15))
                            
                            HStack {
                                Circle()
                                    .frame(width: 13, height: 13)
                                
                                Rectangle()
                                    .frame(width: 50, height: 6)
                            }
                            
                            HStack {
                                Circle()
                                    .frame(width: 13, height: 13)
                                
                                Rectangle()
                                    .frame(width: 0, height: 6)
                            }
                            
                            HStack {
                                Circle()
                                    .frame(width: 13, height: 13)
                                
                                Rectangle()
                                    .frame(width: 25, height: 6)
                            }
                            
                            HStack {
                                Circle()
                                    .frame(width: 13, height: 13)
                                
                                Rectangle()
                                    .frame(width: 0, height: 6)
                            }
                            
                            HStack {
                                Circle()
                                    .frame(width: 13, height: 13)
                                
                                Rectangle()
                                    .frame(width: 25, height: 6)
                            }
                        }
                    }
                }
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 360, height: 130)
                .foregroundStyle(.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1)
                    
                    HStack {
                        Circle()
                            .frame(width: 70, height: 70)
                        
                        VStack {
                            Text("현재 \(viewModel.model.data.nickname) 님의 상태 입니다.")
                                .font(.system(size: 15))
                            
                            HStack(spacing: 30) {
                                Text("D-Day")
                                Text("나이")
                                Text("결혼 년차")
                            }
                            .font(.system(size: 15, weight: .bold))
                            .padding(.vertical, 10)
                            
                            HStack(spacing: 30) {
                                Text(viewModel.model.data.dDay != nil ? "\(viewModel.model.data.dDay)일" : "X")
                                Text("\(viewModel.model.data.age)살")
                                Text(viewModel.model.data.marriedYears != nil ? "\(viewModel.model.data.marriedYears)년차" : "X")
                            }
                            .font(.system(size: 15))
                        }
                        .padding(.horizontal, 20)
                    }
                }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .frame(width: UIScreen.main.bounds.width, height: 220)
        .onAppear {
            viewModel.getMyProfile()
        }
        .padding(.top, -45)
    }
}

#Preview {
    MyStateCell()
}
