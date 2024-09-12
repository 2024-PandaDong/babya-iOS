//
//  HomeView.swift
//  babya
//
//  Created by dgsw8th32 on 5/19/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM = HomeViewModel()
    @StateObject var policyVM = PolicyViewModel.shared
    @StateObject var profileVM = ProfileViewModel.shared
    
    var body: some View {
        ZStack {
            ScrollView() {
                
                CustomPicker()
                
                Divider()
                
                HStack {
                    Text("정책")
                        .font(.system(size: 16, weight: .black))
                    
                    Spacer()
                    
                    NavigationLink(destination: PolicyView()) {
                        Text("더보기")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                
                Divider()
                
                PolicyCell(title: "이승혁이승혁", location: "존잘",  editDate: "2007-12-02", imgUrl: "https://cdn.hankyung.com/photo/201810/01.18067557.1.jpg")
                PolicyCell(title: "이승혁이승혁", location: "존잘",  editDate: "2007-12-02", imgUrl: "https://cdn.hankyung.com/photo/201810/01.18067557.1.jpg")
                PolicyCell(title: "이승혁이승혁", location: "존잘",  editDate: "2007-12-02", imgUrl: "https://cdn.hankyung.com/photo/201810/01.18067557.1.jpg")
                
                HStack {
                    Text("인기 있는 회사")
                        .font(.system(size: 16, weight: .black))
                    
                    Spacer()
                    
                    NavigationLink(destination: CompanySearchView()) {
                        Text("더보기")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                
                Divider()
                
                HStack(spacing: 15) {
                    CompanyCell(title: "부영그룹", image: "")
                    CompanyCell(title: "금호석유화학", image: "")
                    CompanyCell(title: "Posco", image: "")
                }
                .padding(.top, 10)
                
                Spacer()
                    .frame(height: 100)
            }
            CustomTabBar()
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            profileVM.getMyProfile()
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
}
