//
//  AboutMyPregnancyCell.swift
//  babya
//
//  Created by hyk on 9/12/24.
//

import SwiftUI

struct AboutMyPregnancyCell: View {
    let image: String
    let title: String
    let action: () -> ()
    
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
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
    .padding(.horizontal, 30)
    }
}
