//
//  PersonalDataCell.swift
//  SignUp-Narsha
//
//  Created by dgsw8th32 on 4/19/24.
//

import SwiftUI

struct PersonalDataCell: View {
    
    var label: String
    let action: () -> Void
    var isClicked: Bool
    
    init(label: String, isClicked: Bool, action: @escaping () -> Void) {
        self.label = label
        self.isClicked = isClicked
        self.action = action
    }
    
    @State var isPresented: Bool = false
    
    var body: some View {
        HStack {
            
            Button(action: {
                action()
            }, label: {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 22, height: 22)
                    .foregroundStyle(.clear)
                    .overlay {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.gray, lineWidth: 1)
                            
                            Image(systemName: "checkmark")
                                .font(.system(size: 12).weight(.semibold))
                                .foregroundStyle(isClicked ? .black : .clear)
                                
                        }
                    }
            })
            
            Text(label)
                .font(.system(size: 15))
                .foregroundStyle(.black)
            
            Spacer()
            
            Button {
                isPresented.toggle()
            } label: {
                Image(systemName: "arrow.right")
                    .foregroundStyle(.black)
                    
            }
        }
        .sheet(isPresented: $isPresented) {
            Text(label)
        }
    }
}


#Preview {
    PersonalDataCell(label: "개인정보 수집 동의", isClicked: false) {
        
    }
}
