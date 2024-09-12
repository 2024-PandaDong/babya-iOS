//
//  CustomDatePicker.swift
//  SignUp-Narsha
//
//  Created by dgsw8th32 on 4/18/24.
//

import SwiftUI

struct CustomDatePicker: View {
    @StateObject var vm = SignUpViewModel()
    
    let title: String
    var dateFormatter = DateFormatter()
    
    @State var date: Date = Date.now
    @State var showDatePicker: Bool = false
    @Binding var target: String
    
    init(_ title: String, target: Binding<String>) {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.title = title
        self._target = target
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.bold)
                .padding(.vertical, 10)
                    
            HStack {
                Text("\(dateFormatter.string(from: date))")
                    .font(.system(size: 12, weight: .bold))
                
                Spacer()
                
                Button(action: {
                    showDatePicker = true
                }, label: {
                    Image(systemName: "calendar")
                        .foregroundStyle(.black)
                })
                .padding(.trailing, 10)
                .sheet(isPresented: $showDatePicker, content: {
                    if #available(iOS 16.0, *) {
                        DatePicker("", selection: $date, displayedComponents: .date)
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                            .presentationDetents([.fraction(0.35)])
                            .onChange(of: date, perform: { value in
                                target = dateFormatter.string(from: value)
                                print(target)
                            })
                    } else {
                        DatePicker("", selection: $date, displayedComponents: .date)
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                    }
                        
                })
            }
                    
            Rectangle()
                .frame(width: 330, height: 1)
                .foregroundStyle(Color(red: 203/255, green: 203/255, blue: 203/255))
        }
        .padding(.horizontal, 30)
    }
}


#Preview {
    CustomDatePicker("결혼 날짜", target: .constant(""))
}
