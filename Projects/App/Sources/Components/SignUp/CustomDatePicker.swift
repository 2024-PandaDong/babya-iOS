//
//  CustomDatePicker.swift
//  SignUp-Narsha
//
//  Created by dgsw8th32 on 4/18/24.
//

import SwiftUI

struct CustomDatePicker: View {
    @StateObject var vm = SignUpViewModel()
    
    var dateFormatter = DateFormatter()
    
    @State var date: Date = Date.now
    @State var showDatePicker: Bool = false
    @Binding var target: String
    let prompt: String
    
    init(target: Binding<String>, prompt: String) {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self._target = target
        self.prompt = prompt
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(maxWidth: .infinity, minHeight: 55, maxHeight: 55)
            .foregroundStyle(.white)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.LineAlternative)
                
                HStack {
                    Text("\(dateFormatter.string(from: date) == dateFormatter.string(from: Date.now) ? target.isEmpty ? prompt : target : dateFormatter.string(from: date))")
                        .font(.system(size: 16, weight: .semibold))
                    
                    Spacer()
                    
                    Button(action: {
                        showDatePicker = true
                    }, label: {
                        Image(systemName: "calendar")
                    })
                    .padding(.trailing, 10)
                    .sheet(isPresented: $showDatePicker, content: {
                        if #available(iOS 16.0, *) {
                            DatePicker("", selection: $date, displayedComponents: .date)
                                .datePickerStyle(WheelDatePickerStyle())
                                .labelsHidden()
                                .presentationDetents([.fraction(0.35)])
                                .onChange(of: date) { 
                                    target = dateFormatter.string(from: date)
                                    print(target)
                                }
                        } else {
                            DatePicker("", selection: $date, displayedComponents: .date)
                                .datePickerStyle(WheelDatePickerStyle())
                                .labelsHidden()
                        }
                            
                    })
                }
                .padding(.horizontal, 25)
                .foregroundStyle(Color.LabelDisable)
            }
    }
}


#Preview {
    CustomDatePicker(target: .constant(""), prompt: "플레이스홀더입니다.")
}
