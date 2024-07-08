//
//  LocationPicker.swift
//  babya
//
//  Created by dgsw8th32 on 5/7/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct LocationPicker: View {
    @State var showDatePicker: Bool = false
    @Binding var target: String
    @State var selectedLocation: String = ""
    
    let locations: [String : String] = [
        "서울특별시" : "11",
        "부산광역시" : "21",
        "대구광역시" : "22",
        "인천광역시" : "23",
        "대전광역시" : "24",
        "광주광역시" : "25",
        "울산광역시" : "26",
        "세종특별시" : "29",
        "경기도" : "31",
        "강원도" : "32",
        "충청북도" : "33",
        "충청남도" : "34",
        "전라북도" : "35",
        "전라남도" : "36",
        "경상북도" : "37",
        "경상남도" : "38",
        "제주특별자치도" : "39"
    ]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("지역")
                .fontWeight(.bold)
                .padding(.vertical, 10)
                    
            HStack {
                Text("\(selectedLocation)")
                    .font(.system(size: 12, weight: .bold))
                
                Spacer()
                
                Button(action: {
                    showDatePicker = true
                }, label: {
                    Image(systemName: "map")
                        .foregroundStyle(.black)
                })
                .padding(.trailing, 10)
                .sheet(isPresented: $showDatePicker, content: {
                    Picker("", selection: $selectedLocation) {
                        ForEach(locations.keys.sorted(), id: \.self) { key in
                            Text(key)
                        }
                    }
                    .onChange(of: selectedLocation) { newValue in
                        target = locations[newValue] ?? ""
                        print(target)
                    }
                    .pickerStyle(WheelPickerStyle())
                    .presentationDetents([.fraction(0.35)])
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
    LocationPicker(target: .constant(""))
}
