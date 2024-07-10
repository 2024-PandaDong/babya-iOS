//
//  TodoPostView.swift
//  babya
//
//  Created by hyk on 6/27/24.
//

import SwiftUI

struct TodoPostView: View {
    @Binding var category: String
    @Binding var content: String
    @Binding var planedDt: Date
    let action: () -> Void
    
    @FocusState var showKeyboard: Bool
    
    
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var viewModel: TodoViewModel
    
    init(category: Binding<String>, content: Binding<String>, planedDt: Binding<Date>, action: @escaping () -> Void) {
        self._category = category
        self._content = content
        self._planedDt = planedDt
        self.action = action
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("카테고리:")
                    .font(.system(size: 18))
                TextField("", text: $category, prompt: Text("카테고리를 입력해주세요."))
                    .focused($showKeyboard)
                    .onSubmit {
                        print(category)
                    }
            }
            .padding(.vertical, 10)
            
            HStack {
                Text("할 일:")
                    .font(.system(size: 18))
                TextField("", text: $content, prompt: Text("새로운 할 일을 입력해주세요."))
            }
            
            HStack {
                Text("시작일:")
                Image(systemName: "clock")
                DatePicker("", selection: $planedDt, displayedComponents: .date)
                    .labelsHidden()
                    .presentationDetents([.fraction(0.2)])
                    .tint(Color.yellow0)
                
                Spacer()
                
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                    action()
                    category = ""
                    content = ""
                } label: {
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(viewModel.isPostAvailable ? Color.yellow0 : .gray)
                        .overlay {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.white)
                        }
                }
                .disabled(!viewModel.isPostAvailable)
            }
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
    TodoPostView(category: .constant(""), content: .constant(""), planedDt: .constant(.init())) {
        
    }
    .environmentObject(TodoViewModel())
}
