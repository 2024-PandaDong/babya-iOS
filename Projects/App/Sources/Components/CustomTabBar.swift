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
                    
                    CustomTabButton(image: "map", title: "회사찾기", destination: CompanySearchView())
                    
                    Spacer()
                    
                    CustomTabButton(image: "doc.on.clipboard", title: "게시판", destination: NoticeBoardView())
                    
                    Spacer()
                    
                    CustomTabButton(image: "book", title: "산모일기", destination: Text("산모일기"))
                    
                    Spacer()
                    
                    CustomTabButton(image: "list.bullet", title: "투두리스트", destination: TodoListView().environmentObject(TodoViewModel()))
                    
                    Spacer()
                    
                    CustomTabButton(image: "person.circle", title: "프로필", destination: ProfileView())
                   
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