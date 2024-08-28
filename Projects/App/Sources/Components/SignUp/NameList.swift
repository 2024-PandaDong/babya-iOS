import SwiftUI

struct NameList: View {
    let title: String
    let placeholder: String
    @State var content: String = ""
    @Binding var target: [Child]
    let isBirth: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.bold)
            
            HStack {
                TextField("", text: $content, prompt: Text(placeholder).font(.system(size: 14, weight: .semibold)))
                    .tint(.yellow)
                    .textInputAutocapitalization(.never)
                
                Button(action: {
                    if !content.isEmpty {
                        let newChild = Child(name: content, isBirth: isBirth)
                        target.append(newChild)
                        content = ""
                    }
                }, label: {
                    Image(systemName: "checkmark")
                        .foregroundStyle(.black)
                        .offset(x: -10)
                })
                .disabled(content.isEmpty)
            }
            
            Rectangle()
                .frame(width: 330, height: 1)
                .foregroundStyle(Color(red: 203/255, green: 203/255, blue: 203/255))
            
            ForEach(target) { child in
                VStack(alignment: .leading) {
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
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 3)
                                            .stroke(.black, lineWidth: 1)
                                        
                                        Image(systemName: "xmark")
                                            .font(.system(size: 10))
                                            .foregroundStyle(.black)
                                    }
                                }
                        })
                        .offset(x: -10)
                    }
                    
                    Rectangle()
                        .frame(width: 330, height: 1)
                        .foregroundStyle(Color(red: 203/255, green: 203/255, blue: 203/255))
                }
                .padding(.top, 5)
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 5)
    }
}

#Preview {
    SecondSignUpView()
        .environmentObject(SignUpViewModel())
}
