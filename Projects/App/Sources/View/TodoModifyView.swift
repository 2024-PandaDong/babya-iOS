//
//  TodoModifyView.swift
//  babya
//
//  Created by hyk on 7/10/24.
//

import SwiftUI

struct TodoModifyView: View {
    @Binding var id: Int
    @Binding var category: String
    @Binding var content: String
    @Binding var planedDt: String
    let action: () -> Void
    
    @FocusState var showKeyboard: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var viewModel: TodoViewModel
    
    init(id: Binding<Int>, category: Binding<String>, content: Binding<String>, planedDt: Binding<String>, action: @escaping () -> Void) {
        self._id = id
        self._category = category
        self._content = content
        self._planedDt = planedDt
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
    TodoModifyView(id: .constant(0), category: .constant(""), content: .constant(""), planedDt: .constant("")) {
        
    }
}
