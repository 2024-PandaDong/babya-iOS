//
//  CompanyDetailView.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI

struct CompanyDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    var companyId: Int
    @StateObject var vm : CompanyViewModel = .init(companyService: RemoteCompanyService())
    
    @State private var isExpanded: Bool = false
    @State private var currentIndex = 0
    
    var body: some View {
        ZStack(alignment:.bottom){
            ScrollView {
                VStack {
                    if let imageUrl = URL(string: vm.companyInfo?.contentImg ?? "dummy"){
                        AsyncImage(url: imageUrl) { image in
                            image
                                .resizable()
                        } placeholder: {
                            Image("dummy")
                                .resizable()
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 190)
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(vm.companyInfo?.name ?? "회사를 찾을 수 없음")
                            .font(.system(size: 24, weight: .semibold))
                        HStack {
                            Text(vm.companyInfo?.businessType ?? "")
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
                        
                        Text(isExpanded ? (vm.companyInfo?.description ?? "") :
                                (vm.companyInfo?.description.prefix(50) ?? "") +
                             (vm.companyInfo?.description.count ?? 0 > 50 ? "..." : "")
                        )
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(Color.black)
                        
                        if vm.companyInfo?.description.count ?? 0 > 50 {
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
                            
                            Text("2024년 기준")
                                .font(.system(size:14,weight: .medium ))
                                .foregroundStyle(Color.Opacity35)
                        }
                        .padding(.vertical,17)
                        
                        SalaryInfoCell(salaries: ["\(vm.companyInfo?.minSalary ?? 0)만원", "\(vm.companyInfo?.avgSalary ?? 0)만원", "\(vm.companyInfo?.maxSalary ?? 0)만원"])
  
                        
                        Text("인원")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundStyle(Color.black)
                            .padding(.vertical,17)
                        
                        CompanyCharts(data: System.dummyData(salaries: [
                            "\(String(describing: vm.companyInfo?.malePeople))%",
                            "\(String(describing: vm.companyInfo?.femalePeople))%"]),
                                      salaries: ["\((vm.companyInfo?.malePeople ?? 0) + (vm.companyInfo?.femalePeople ?? 0))명",
                                "\(vm.companyInfo?.malePeople ?? 0)%",
                                "\(vm.companyInfo?.femalePeople ?? 0)%"])
                        .padding(.horizontal,20)
                        
                        Text("기업 정보")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundStyle(Color.black)
                            .padding(.vertical,17)
                        
                        CompanyInfoCell(address: vm.companyInfo?.address ?? "주소를 찾을 수 없음",
                                        ceo: vm.companyInfo?.ceo ?? "대표자 없음",
                                        tel: vm.companyInfo?.tel ?? "전화번호 정보가 없음",
                                        historyYear: vm.companyInfo?.historyYear ?? "설립일을 알수없음",
                                        businessContent: vm.companyInfo?.businessContent ?? "사업 내용 정보 없음",
                                        companyType: vm.companyInfo?.companyType ?? "회사유형이 없음")
                        
                        Text("혜택 및 복지")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundStyle(Color.black)
                            .padding(.vertical,17)
                        
                        Text(vm.companyInfo?.subsdType ?? "혜택이 없음")
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
            
            if let url = URL(string: vm.companyInfo?.link ?? "https://www.google.com") {
                Link(destination: url) {
                    CompanyButton(content: "회사 더 알아보기")
                }
            }
        }
        .task {
            await vm.detailCompany(Id: companyId)
        }
        .navigationBarBackButtonHidden(true)
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
    }
}
