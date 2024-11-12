//
//  CustomTabButton.swift
//  CustomTabView
//
//  Created by dgsw8th32 on 4/11/24.
//

import SwiftUI
import FlowKit

struct CustomTabButton: View {
    let image: String
    let title: String
    let destination: TabItem
    @Flow var flow
    
    init(image: String, title: String, destination: TabItem) {
        self.image = image
        self.title = title
        self.destination = destination
    }
    
    var body: some View {
        Button{
            flow.push(destination.view,animated: false)
        }label: {
            VStack {
                Image(systemName: image)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(Color(red: 117/255, green: 117/255, blue: 117/255))
                
                Text(title)
                    .fontWeight(.bold)
                    .font(.custom("Apple SD Gothic Neo", size: 10))
                    .foregroundStyle(Color(red: 117/255, green: 117/255, blue: 117/255))
            }
        }
        
    }
}

#Preview {
    CustomTabButton(image: "house", title: "홈", destination: .diary)
}
