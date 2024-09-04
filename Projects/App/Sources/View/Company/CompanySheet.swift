//
//  CompanySheet.swift
//  babya
//
//  Created by dgsw8th61 on 9/4/24.
//

import SwiftUI

struct CompanySheet : View {
    var body: some View {
        VStack{
            Text("지역을 선택해주세요.")
                .font(.system(size: 16,weight: .semibold))
                .foregroundStyle(Color.black)
            
            Button {

            } label: {
//                RoundedRectangle(cornerRadius: 10)
//                    .frame(height: 25)
//                    .frame(maxWidth: 110)
//                    .foregroundStyle(.white)
//                    .overlay {
//                        ZStack{
//                            RoundedRectangle(cornerRadius: 8).stroke(Color.LabelDisable)
//                            Text("대구광역시")
//                               .font(.system(size: 14,weight: .medium))
//                                .foregroundColor(Color.LabelDisable)
//                        }
//                    }
                
                Text("대구광역시")
                    .font(.system(size: 14,weight: .medium))
                    .foregroundColor(Color.LabelDisable)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(style: Color.LabelDisable)
                    }
                //7 간격
            }
            
            Text("군을 선택해주세요.")
                .font(.system(size: 16,weight: .semibold))
                .foregroundStyle(Color.black)
            Text("거주 지역을 선택해주세요.")
                .font(.system(size: 16,weight: .semibold))
                .foregroundStyle(Color.black)
            
            CompanyButton(content: "검색하기")
        }
    }
}

#Preview {
    CompanySheet()
}
