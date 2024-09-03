//
//  CompanyInfoCell.swift
//  babya
//
//  Created by dgsw8th61 on 8/29/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct CompanyInfoCell: View {
    var address : String
    var body: some View {
        VStack(alignment: .leading ,spacing: 9){
            HStack(alignment:.top,spacing: 70) {
                Text("대표자명")
                    .textNormalStyle()
                
                Text("한종희")
                    .textContentStyle()
            }
            
            HStack(alignment:.top,spacing: 70) {
                Text("고객 서비스")
                    .textNormalStyle()
                
                Text("080-022-3000")
                    .textContentStyle()
            }
            
            HStack(alignment:.top,spacing: 70) {
                Text("본사 위치")
                    .textNormalStyle()
                VStack(alignment: .leading,spacing: 3){
                    Text(address)
                        .textContentStyle()
                    
                    Button(action: {
                        let pasteboard = UIPasteboard.general
                        pasteboard.string = address
                    }) {
                        HStack(spacing: 2) {
                            Image("copy")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 17, height: 17)
                            
                            Text("주소복사")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(Color.PrimaryLight)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            
            HStack(alignment:.top,spacing: 70) {
                Text("연혁")
                    .textNormalStyle()
                
                Text("17년(2007년설립)")
                    .textContentStyle()
            }
            
            HStack(alignment:.top,spacing: 70) {
                Text("사업 내용")
                    .textNormalStyle()
                
                Text("삼성그룹 계열 종합물류/무역/레저/건설 회사[2]이자 삼성의 모태가 되는 회사.")
                    .textContentStyle()
            }
            
            HStack(alignment:.top,spacing: 70) {
                Text("기업 유형")
                    .textNormalStyle()
                
                Text("대기업")
                    .textContentStyle()
            }
        }
    }
}
extension View {
    func textNormalStyle() -> some View {
        self
            .font(.system(size: 12,weight: .semibold))
            .foregroundStyle(Color.black)
            .padding(.bottom,9)
            .frame(width: 60, alignment: .leading)
    }
    
    func textContentStyle() -> some View {
        self
            .font(.system(size: 12,weight: .medium))
            .foregroundStyle(Color.Opacity35)
            .padding(.bottom,9)
    }
}
#Preview {
    CompanyInfoCell(address: "서울특별시 강동구 상일로6길 26 (상일동)")
}
