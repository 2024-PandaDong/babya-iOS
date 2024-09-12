//
//  CustomTabView.swift
//  CustomTabView
//
//  Created by dgsw8th32 on 4/11/24.
//

import SwiftUI

struct CustomTabBar: View {
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: UIScreen.main.bounds.width, height: 100)
                    .foregroundStyle(Color(red: 245/255, green: 245/255, blue: 245/255))
                .shadow(radius: 3, y: -2)
                
                HStack {
                    Spacer()
                    
                    CustomTabButton(image: "map", title: "회사찾기", destination: .company)
                    
                    Spacer()
                    
                    CustomTabButton(image: "doc.on.clipboard", title: "정책정리", destination: .policy)
                    
                    Spacer()
                    
                    CustomTabButton(image: "book", title: "산모일기", destination: .diary)
                    
                    Spacer()
                    
                    CustomTabButton(image: "list.bullet", title: "투두리스트", destination: .todo)
                    
                    Spacer()
                    
                    CustomTabButton(image: "person.circle", title: "프로필", destination: .profile)
                   
                    Spacer()
                }
                .padding(.bottom)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CustomTabBar()
}
