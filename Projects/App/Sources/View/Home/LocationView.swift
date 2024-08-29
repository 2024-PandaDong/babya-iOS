//
//  LocationView.swift
//  babya
//
//  Created by hyk on 8/29/24.
//

import SwiftUI

struct LocationView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("지역을 선택해주세요.")
                Text("군을 선택해주세요.")
                Text("거주 지역을 선택해주세요.")
            }
            .padding(.vertical, 10)
            
            Spacer()
            
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 320, height: 45)
                    .foregroundStyle(Color.PrimaryLight)
                    .overlay {
                        Text("검색하기")
                            .foregroundStyle(.white)
                    }
            }
        }
        .padding(.vertical)
        .font(.system(size: 16, weight: .semibold))
    }
}

#Preview {
    LocationView()
}
