//
//  PersonalDataCell.swift
//  SignUp-Narsha
//
//  Created by dgsw8th32 on 4/19/24.
//

import SwiftUI

struct PersonalDataCell: View {
    
    var label: String
    let index: Int
    let action: () -> Void
    var isClicked: Bool
    
    init(label: String, index: Int, isClicked: Bool, action: @escaping () -> Void) {
        self.label = label
        self.index = index
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
                    .foregroundStyle(isClicked ? Color.PrimaryLight : .clear)
                    .overlay {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.gray, lineWidth: 1)
                            
                            Image(systemName: "checkmark")
                                .font(.system(size: 12).weight(.semibold))
                                .foregroundStyle(.white)
                                
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
            if index == 0 {
                WebViewer(url: "https://www.notion.so/1169bbf0448c80e1accdc3511654fe06")
            } else if index == 1 {
                WebViewer(url: "https://www.notion.so/1279bbf0448c80eeba5fe9cfbca9b6d8")
            } else if index == 2 {
                WebViewer(url: "https://www.notion.so/3-1279bbf0448c80be9767c7a189419f7b")
            }
        }
    }
}


#Preview {
    PersonalDataCell(label: "개인정보 수집 동의", index: 0, isClicked: false) {
        
    }
}
