//
//  FourthSignUpView.swift
//  babya
//
//  Created by hyk on 9/12/24.
//

import SwiftUI

struct FourthSignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var viewModel: SignUpViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                Group {
                    Text("당신은 현재...")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.top, 40)
                    
                    AboutMyPregnancyCell(image: "planing", title: "임신을 계획하고 있어요!") {
                        viewModel.familyType = 1
                        viewModel.pageNum += 2
                        viewModel.isPlaning = true
                    }
                    
                    AboutMyPregnancyCell(image: "inPregnancy", title: "  임신중이에요!") {
                        viewModel.familyType = 2
                        viewModel.pageNum += 1
                    }
                    
                    AboutMyPregnancyCell(image: "hasBaby", title: "  귀여운 아기가 있어요!") {
                        viewModel.familyType = 3
                        viewModel.pageNum += 1
                    }
                    
                    AboutMyPregnancyCell(image: "withFamily", title: "귀여운 아이, 태아 모두 있어요!") {
                        viewModel.familyType = 4
                        viewModel.pageNum += 1
                    }
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    NavigationView {
        FourthSignUpView()
            .environmentObject(SignUpViewModel())
    }
}
