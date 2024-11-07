//
//  CompanyInfoCell.swift
//  babya
//
//  Created by dgsw8th61 on 8/29/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct CompanyInfoCell: View {
    let address : String
    let ceo : String
    let tel: String
    let historyYear: String
    let businessContent: String
    let companyType: String
    
    var body: some View {
        VStack(alignment: .leading ,spacing: 9){
            infoLayout(text1: "대표자명", text2: ceo)
            
            infoLayout(text1: "고객 서비스", text2: tel)
            
            HStack(alignment:.top,spacing: 60) {
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
            
            infoLayout(text1:"연혁", text2: historyYear)
            
            infoLayout(text1: "사업 내용", text2: businessContent)
            
            infoLayout(text1: "기업 유형", text2: companyType)
        }
    }
}
extension View {
    func textNormalStyle() -> some View {
        self
            .font(.system(size: 12,weight: .semibold))
            .foregroundStyle(Color.black)
            .padding(.bottom,9)
            .frame(width: 140, alignment: .leading)
    }
    
    func textContentStyle() -> some View {
        self
            .font(.system(size: 12,weight: .medium))
            .foregroundStyle(Color.Opacity35)
            .padding(.bottom,9)
    }
    
    func infoLayout(text1: String, text2: String) -> some View {
        HStack(alignment:.top,spacing: 60) {
            Text(text1)
                .textNormalStyle()
            
            Text(text2)
                .textContentStyle()
        }
    }
}
