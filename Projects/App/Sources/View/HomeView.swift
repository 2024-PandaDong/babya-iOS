//
//  HomeView.swift
//  babya
//
//  Created by dgsw8th32 on 5/19/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: 40)
                    .foregroundStyle(.yellow)
                    .overlay {
                        HStack(spacing: 20) {
                            Image(systemName: "speaker.wave.1")
                                .foregroundStyle(.black)
                            
                            Text("대구광역시 출산 정책 이렇게 달라집니다.")
                                .font(.system(size: 12))
                            
                            Spacer()
                            
                            Image(systemName: "play")
                        }
                        .padding(.horizontal)
                    }
                
                CustomPicker()
                
                MyStateCell()
                
                HStack {
                    Text("현재 인기 회사")
                        .font(.system(size: 16, weight: .black))
                    
                    Spacer()
                    
                    NavigationLink(destination: Text("회사찾기")) {
                        Text("더보기")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal, 20)
                
                HStack(spacing: 15) {
                    CompanyCell(title: "부영그룹", image: "")
                    CompanyCell(title: "금호석유화학", image: "")
                    CompanyCell(title: "Posco", image: "")
                }
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("애기야")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(LinearGradient(colors: [.yellow, .mint], startPoint: .leading, endPoint: .trailing))
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Circle()
                        .frame(width: 25, height: 25)
                }
            }
            CustomTabBar()
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
}
