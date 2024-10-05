import Foundation
import SwiftUI

struct InputFieldView: View {
    @Binding var text: String
    @Binding var securetext: String
    @Binding var showPassword: Bool
    var errorMessage: String?
    var placeholder: String
    var isSecure: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if isSecure {
                    if showPassword {
                        TextField(placeholder, text: $securetext)
                            .customTextField()
                            .padding(.bottom, -1.8)
                    } else {
                        SecureField(placeholder, text: $securetext)
                            .customTextField()
                    }
                    
                    Button {
                        self.showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eye" : "eye.slash")
                            .foregroundStyle(!securetext.isEmpty ? Color.PrimaryNormal : .clear)
                    }
                    .disabled(securetext.isEmpty)
                } else {
                    TextField(placeholder, text: $text)
                        .customTextField()

                }
            }
            .textInputAutocapitalization(.never)
            .padding(.bottom, 1)
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color.LineNormal)
            
            Text(errorMessage ?? "         ")
                .font(.system(size: 13))
                .foregroundColor(errorMessage != nil ? .red : .clear)
        }
    }
}

#Preview {
    InputFieldView(text: .constant(""), securetext: .constant(""), showPassword: .constant(false), errorMessage: "잘못입력함", placeholder: "입력하세요", isSecure: true)
        .padding(.horizontal, 20)
}

extension View {
    func customTextField() -> some View {
        self
            .textFieldStyle(PlainTextFieldStyle())
            .background(Color.clear)
    }
}
