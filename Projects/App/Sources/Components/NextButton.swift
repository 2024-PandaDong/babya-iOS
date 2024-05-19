//
//  SignUpButton.swift
//  SignUp-Narsha
//
//  Created by dgsw8th32 on 4/20/24.
//

import SwiftUI

struct NextButton: View {
    @StateObject var vm = SignUpViewModel()
    let title: String
    let content: () -> AnyView
    let destination: () -> AnyView
    let action: () -> Void
    let disable: Bool
    
    init(title: String, content: @escaping () -> AnyView, destination: @escaping () -> AnyView, action: @escaping () -> Void, disable: Bool) {
        self.title = title
        self.content = content
        self.destination = destination
        self.action = action
        self.disable = disable
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                content()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                NavigationLink {
                   destination()
                        .onAppear {
                            action()
                        }
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 340, height: 50)
                        .foregroundStyle(vm.isFirstSignUpAvailable ? Color(red: 255/255, green: 203/255, blue: 41/255) : .gray)
                        .overlay {
                            Text(title)
                                .foregroundStyle(.white)
                                .font(.system(size: 15, weight: .bold))
                        }
                }
                .padding(.bottom)
                .disabled(vm.isFirstSignUpAvailable ? false : true)
            }
        }
    }
}

#Preview {
    VStack {
        
    }
    .nextButton(title: "다음", destination: SecondSignUpView())
}
