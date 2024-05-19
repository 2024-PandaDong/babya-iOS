//
//  YesOrNoCell.swift
//  babya
//
//  Created by dgsw8th32 on 5/2/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct CheckBoxCell: View {
    @StateObject var vm = SignUpViewModel()
    let title: String
    @Binding var isCheck : Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("\(title)")
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("네")
                    .font(.system(size: 15))
                
                Button(action: {
                    withAnimation {
                        isCheck = true
                    }
                    print("\(title) : \(isCheck)")
                }, label: {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 17, height: 17)
                        .foregroundStyle(isCheck ? .green : .white)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5).stroke(.black)
                        }
                })
                
                Text("아니요")
                    .font(.system(size: 15))
                
                Button(action: {
                    withAnimation {
                        isCheck = false
                    }
                    print("\(title) : \(isCheck)")
                }, label: {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 17, height: 17)
                        .foregroundStyle(isCheck ? .white : .red)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5).stroke(.black)
                        }
                })
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 5)
        }
    }
}

#Preview {
    CheckBoxCell(title: "임신여부", isCheck: .constant(true))
}
