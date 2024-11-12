//
//  BabyaScrollView.swift
//  babya
//
//  Created by dgsw8th61 on 11/4/24.
//

import SwiftUI

public struct BabyaScrollView<Content: View>: View {
    public let title: String
    public let buttons: [BabyaTopAppBarButton]
    public let content: () -> Content

    @State private var blueOpacity: CGFloat = 0

    public init(title: String, buttons: [BabyaTopAppBarButton] = [], @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.buttons = buttons
        self.content = content
    }

    public var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: false) {
                content()
                    .padding(.top, 8)
                    .background(
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    let yOffset = geometry.frame(in: .global).minY
                                    blueOpacity = max(min(-yOffset / 100, 1), 0)
                                }
                        }
                    )
            }
            .background(Color.white)
            
          
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                ForEach(buttons, id: \.id) { button in
                    button.action
                }
            }
            .background(Color.blue.opacity(blueOpacity))
            .cornerRadius(10)
            .padding(.top, 0)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

public struct BabyaTopAppBarButton {
    public let id = UUID()
    public let icon: String
    public let action: AnyView 

    public init(icon: String, action: AnyView) {
        self.icon = icon
        self.action = action
    }
}

