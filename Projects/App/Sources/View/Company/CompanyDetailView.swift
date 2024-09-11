//
//  CompanyDetailView.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI

struct CompanyDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    var title: String
    var category: String
    var content: String
    
    @State private var isExpanded: Bool = false
    @State private var currentIndex = 0
    
    var body: some View {
        ZStack(alignment:.bottom){
            ScrollView {
                VStack {
                    TabView(selection: $currentIndex){
                        ForEach(0..<3, id: \.self) { index in
                            Image("dummy")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 190)
                                .frame(maxWidth: .infinity)
                                .clipped()
                                .ignoresSafeArea(edges: .top)
                        }
                    }
                    
                    .frame(height: 190)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .overlay{
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 33,height: 21)
                                    .opacity(0.6)
                                    .padding(10)
                                    .overlay{
                                        Text("\(currentIndex + 1)/3")
                                            .foregroundStyle(Color.white)
                                            .font(.system(size: 12,weight: .medium))
                                    }
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(.system(size: 24, weight: .semibold))
                        HStack {
                            Text(category)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(Color.black)
                            
                            Spacer()
                            
                            Image("star")
                                .resizable()
                                .frame(width: 16, height: 14)
                            
                            Text("4.5")
                                .font(.system(size: 16))
                                .foregroundStyle(.black)
                        }
                        .padding(.vertical, 6)
                        
                        Text(isExpanded ? content : String(content.prefix(50)) + (content.count > 50 ? "..." : ""))
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(Color.black)
                        
                        if content.count > 50 {
                            Button(action: {
                                isExpanded.toggle()
                            }) {
                                Text(isExpanded ? "닫기" : "더보기")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(Color.Opacity35)
                            }
                            .padding(.top, 5)
                        }
                        HStack(spacing:5){
                            Text("연봉")
                                .font(.system(size: 16,weight: .semibold))
                                .foregroundStyle(Color.black)
                            
                            Text("9314년 기준")
                                .font(.system(size:14,weight: .medium ))
                                .foregroundStyle(Color.Opacity35)
                        }
                        .padding(.vertical,17)
                        
                        SalaryInfoCell(salaries: ["11,760만원", "11,765만원", "11,730만원"])
                        
                        Text("인원")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundStyle(Color.black)
                            .padding(.vertical,17)
                        
                        
                        CompanyCharts(data: System.dummyData(salaries: ["50%", "50%"]), salaries: ["100명", "50%", "50%"])
                            .padding(.horizontal,20)
                        
                        
                        Text("기업 정보")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundStyle(Color.black)
                            .padding(.vertical,17)
                        
                        CompanyInfoCell(address: "서울특별시 강동구 상일로6길 26 (상일동)")
                        
                        Text("혜택 및 복지")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundStyle(Color.black)
                            .padding(.vertical,17)
                        
                        Text("첫째 500만 원, 둘째 1천만 원, 셋째 2천만 원 출산 지원")
                            .font(.system(size: 14,weight: .regular))
                            .foregroundStyle(Color.black)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 18)
                    .padding(.top, 20)
                    .padding(.bottom,80)
                    Spacer()
                }
            }
            CompanyButton(content: "회사 더 알아보기")
        }
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(Color.white)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}
#Preview {
    NavigationView {
        CompanyDetailView(title: "삼성전자",
                          category: "IT, 동영상 | 서울 수원시",
                          content: "삼성전자는 사람과 사회를 생각하는 글로벌 일류기업을 추구합니다. ‘경영이념, 핵심가치, 경영원칙’의 원칙이 많다")
    }
}