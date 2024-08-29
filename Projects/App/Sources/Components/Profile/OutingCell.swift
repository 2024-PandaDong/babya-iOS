//
//  OutingCell.swift
//  babya
//
//  Created by hyk on 8/29/24.
//

import SwiftUI

struct OutingCell: View {
    let title: String
    @State var isClicked: Bool = false
    let action: () -> ()
    
    var body: some View {
        Button {
            self.isClicked = true
        } label: {
            Rectangle()
                .frame(height: 60)
                .foregroundStyle(.white)
                .overlay {
                    HStack {
                        Text(title)
                            .foregroundStyle(Color.red0)
                            .font(.system(size: 16, weight: .medium))
                        
                        Spacer()
                    }
                    .padding(.horizontal, 25)
                }
        }
        .alert(isPresented: $isClicked) {
            Alert(
                title: Text(title),
                message: Text("정말로 \(title) 하시겠습니까?"),
                primaryButton: .destructive(
                    Text(title),
                    action: {
                        action()
                    }
                ),
                secondaryButton: .default(Text("취소"))
            )
        }
    }
}

#Preview {
    ZStack {
        Color.PrimaryLight
        
        OutingCell(title: "로그아웃") {
            
        }
    }
}
