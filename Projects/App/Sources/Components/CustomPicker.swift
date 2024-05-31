//
//  CustomPicker.swift
//  babya
//
//  Created by dgsw8th32 on 5/27/24.
//

import SwiftUI

enum CurrentTab {
    case before, after
}

struct CustomPicker: View {
    @State var currentTab: CurrentTab = .before
    
    func changeView(currenTab: CurrentTab) -> AnyView {
        switch currentTab {
        case .before:
            return AnyView(Text("출산전"))
        case .after:
            return AnyView(Text("출산후"))
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text("출산전")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(self.currentTab == .before ? .black : .gray)
                    .onTapGesture {
                        withAnimation {
                            self.currentTab = .before
                        }
                    }
                
                
                Text("출산후")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(self.currentTab == .after ? .black : .gray)
                    .onTapGesture {
                        withAnimation {
                            self.currentTab = .after
                        }
                    }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
            Rectangle()
                .frame(width: 45, height: 2)
                .foregroundStyle(.yellow)
                .padding(.horizontal, 18)
                .offset(x: self.currentTab == .after ? 50 : 0)
            
            if self.currentTab == .before {
                TabView {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 355, height: 200)
                        .foregroundStyle(.white)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1)
                            
                            Text("출산 혜택")
                        }
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 355, height: 200)
                        .foregroundStyle(.white)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1)
                            
                            Text("저출산 정책")
                        }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .frame(width: UIScreen.main.bounds.width, height: 220)
            } else {
                TabView {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 355, height: 200)
                        .foregroundStyle(.white)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1)
                            
                            Text("다자녀 혜택")
                        }
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 355, height: 200)
                        .foregroundStyle(.white)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1)
                            
                            Text("지원금")
                        }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .frame(width: UIScreen.main.bounds.width, height: 220)
            }
        }
    }
}

#Preview {
    HomeView()
}
