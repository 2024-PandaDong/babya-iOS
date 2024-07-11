//
//  TodoModifyView.swift
//  babya
//
//  Created by hyk on 7/10/24.
//

import SwiftUI

struct TodoModifyView: View {
    @Binding var content: String
    let action: () -> Void
    
    @FocusState var showKeyboard: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var viewModel: TodoViewModel
    
    init(content: Binding<String>, action: @escaping () -> Void) {
        self._content = content
        self.action = action
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("할 일:")
                TextField("", text: $content, prompt: Text("새로운 할 일을 입력해주세요."))
                
                Spacer()
                
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                    action()
                    content = ""
                } label: {
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color.yellow0)
                        .overlay {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.white)
                        }
                }
            }
            .presentationDetents([.fraction(0.1)])
            .font(.system(size: 18))
            .padding(.vertical, 20)
        }
        .padding(.horizontal, 25)
        .onAppear() {
            showKeyboard = true
        }
    }
}

#Preview {
    TodoModifyView(content: .constant("")) {
        
    }
}
