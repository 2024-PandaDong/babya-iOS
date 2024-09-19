//
//  AboutMyPregnancyCell.swift
//  babya
//
//  Created by hyk on 9/12/24.
//

import SwiftUI

struct AboutMyPregnancyCell: View {
    @EnvironmentObject var viewModel: SignUpViewModel
    
    let image: String
    let title: String
    let action: () -> ()
    
    var body: some View {
        NavigationLink(destination: FifthSignUpView().environmentObject(viewModel).onAppear{action()}) {
            RoundedRectangle(cornerRadius: 10)
                .frame(maxWidth: .infinity, maxHeight: 55)
                .foregroundStyle(.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.LineAlternative)
                    
                    HStack(spacing: 20) {
                        Image(image)
                        
                        Text(title)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.black)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 25)
                }
        }
    }
}

#Preview {
    NavigationView {
        AboutMyPregnancyCell(image: "hasBaby", title: "아이가 있어요.") {
            
        }
        .environmentObject(SignUpViewModel())
    .padding(.horizontal, 30)
    }
}
