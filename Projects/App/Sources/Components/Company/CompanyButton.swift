//
//  CompanyButton.swift
//  babya
//
//  Created by dgsw8th61 on 8/30/24.
//

import SwiftUI

struct CompanyButton: View {
    var content: String
    var body: some View {
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 43)
                .foregroundColor(Color.PrimaryLight)
                .cornerRadius(10)
                .overlay{
                    Text(content)
                        .font(.system(size: 16,weight: .bold))
                        .foregroundColor(.white)
                }
                .padding()
                .padding(.bottom,30)
    }
}
