import SwiftUI

struct NameList: View {
    let placeholder: String
    @State var content: String = ""
    @Binding var target: [Child]
    let isBirth: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .frame(maxWidth: .infinity, minHeight: 55, maxHeight: 55)
                .foregroundStyle(.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.LineAlternative)
                    
                    HStack {
                        TextField("", text: $content, prompt: Text(placeholder).font(.system(size: 16, weight: .semibold)))
                            .tint(Color.PrimaryNormal)
                            .textInputAutocapitalization(.never)
                        
                        Button(action: {
                            if !content.isEmpty {
                                let newChild = Child(name: content, isBirth: isBirth)
                                target.append(newChild)
                                content = ""
                            }
                        }, label: {
                            Image(systemName: "person.badge.plus")
                                .offset(x: -10)
                                .foregroundStyle(content.isEmpty ? Color.LabelAssistive : .PrimaryNormal)
                        })
                        .disabled(content.isEmpty)
                    }
                    .padding(.horizontal, 25)
                }
            
            ForEach(target) { child in
                RoundedRectangle(cornerRadius: 10)
                    .frame(maxWidth: .infinity, minHeight: 55, maxHeight: 55)
                    .foregroundStyle(.white)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.LineAlternative)
                        
                        HStack {
                            Text("\(child.name)")
                                .font(.system(size: 15, weight: .bold))
                            
                            Spacer()
                            
                            Button(action: {
                                if let index = target.firstIndex(where: { $0.id == child.id }) {
                                    target.remove(at: index)
                                }
                            }, label: {
                                RoundedRectangle(cornerRadius: 3)
                                    .frame(width: 22, height: 18)
                                    .foregroundStyle(.white)
                                    .overlay {
                                        Image(systemName: "xmark")
                                            .font(.system(size: 15))
                                            .foregroundStyle(Color.PrimaryNormal)
                                    }
                            })
                        }
                        .padding(.horizontal, 25)
                    }
                    .padding(.top, 10)
            }
        }
    }
}

#Preview {
    NavigationView {
        NameList(placeholder: "망고", target: .constant([Child(name: "망고", isBirth: true)]), isBirth: true)
            .environmentObject(SignUpViewModel())
    }
}
