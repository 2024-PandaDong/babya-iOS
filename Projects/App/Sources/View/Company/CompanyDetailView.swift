//
//  CompanyDetailView.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI
import FlowKit

struct CompanyDetailView: View {
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var presentationMode
    var companyId: Int
    @StateObject var vm : CompanyViewModel = .init(companyService: RemoteCompanyService())
    
    @State private var isExpanded: Bool = false
    @State private var currentIndex = 0
    @Flow var flow
    
    var body: some View {
        ZStack(alignment:.bottom){
            ScrollView {
                VStack {
                    if let imageUrl = URL(string: vm.companyInfo?.contentImg ?? "dummy"){
                        AsyncImage(url: imageUrl) { image in
                            image
                                .resizable()
                        } placeholder: {
                            if let image = vm.companyInfo?.contentImg {
                                AsyncImage(url: URL(string: image)) { image in
                                    image.image?
                                        .resizable()
                                }
                            } else {
                              ProgressView()
                            }
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
                        
                        if vm.companyInfo?.malePeople != 0 && vm.companyInfo?.femalePeople != 0 {
                            Text("인원")
                                .font(.system(size: 16,weight: .semibold))
                                .foregroundStyle(Color.black)
                                .padding(.vertical,17)

                            CompanyCharts(data: System.dummyData(salaries: [
                                "\(vm.companyInfo?.malePeople ?? 0)%",
                                "\(vm.companyInfo?.femalePeople ?? 0)%"]),
                                          salaries: ["\((vm.companyInfo?.malePeople ?? 0) + (vm.companyInfo?.femalePeople ?? 0))명",
                                                     "\(vm.companyInfo?.malePeople ?? 0)명",
                                                     "\(vm.companyInfo?.femalePeople ?? 0)명"])
                            .padding(.horizontal,20)
                            
                        } else {
                            Spacer()
                                .frame(height: 20)
                        }
                        
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
                        
                        WelfareInfoView(title: "육아휴직 기간", value: (vm.companyInfo?.mtrLvPeriod))
                        WelfareInfoView(title: "유급 여부", value: (vm.companyInfo?.mtrLvIsSalary == "N" ? "X" : vm.companyInfo?.mtrLvIsSalary) ?? "")
                        WelfareInfoView(title: "육아휴직 급여 비율", value: (vm.companyInfo?.mtrLvSalary))
                        WelfareInfoView(title: "출산 비용 지원 조건", value: (vm.companyInfo?.mtrSupCondition == "N" ? "X" : vm.companyInfo?.mtrSupCondition) ?? "")
                        WelfareInfoView(title: "출산 비용 지원금", value: (vm.companyInfo?.mtrSupMoney))
                        WelfareInfoView(title: "재택 근무 가능 여부", value: (vm.companyInfo?.telComIsCan == "N" ? "X" : vm.companyInfo?.telComIsCan) ?? "")
                        WelfareInfoView(title: "재택 근무 일 수", value: (vm.companyInfo?.telComDays))
                        WelfareInfoView(title: "재택 근무 시간", value: (vm.companyInfo?.telComTime))
                        WelfareInfoView(title: "보조금 지원 종류", value: (vm.companyInfo?.subsdType == "N" ? "X" : vm.companyInfo?.subsdType) ?? "")
                        WelfareInfoView(title: "보조금 지원액", value: (vm.companyInfo?.subsdMoney))
                        
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
//                    self.presentationMode.wrappedValue.dismiss()
                    flow.pop()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.black)
                }
            }
        }
        .toolbarBackground(.white)
        .gesture(DragGesture().updating($dragOffset) { (value, state, transaction) in
            if (value.startLocation.x < 30 && value.translation.width > 100) {
                self.presentationMode.wrappedValue.dismiss()
            }
        })
    }
}
