//
//  LocationPicker.swift
//  babya
//
//  Created by dgsw8th32 on 5/7/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct LocationPicker: View {
    @EnvironmentObject var viewModel: SignUpViewModel
    @State var showLocationPicker: Bool = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(maxWidth: .infinity, minHeight: 55, maxHeight: 55)
            .foregroundStyle(.white)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.LineAlternative)
                
                HStack {
                    Text("\(viewModel.selectedState?.name ?? "") \(viewModel.selectedDistrict)")
                        .font(.system(size: 16, weight: .semibold))
                    
                    Spacer()
                    
                    Button(action: {
                        showLocationPicker = true
                    }, label: {
                        Image(systemName: "map")
                            .foregroundStyle(Color.LabelDisable)
                    })
                    .padding(.trailing, 10)
                    .sheet(isPresented: $showLocationPicker) {
                        SignUpLocationView()
                            .environmentObject(viewModel)
                    }
                    .foregroundStyle(.black)
                }
                .padding(.horizontal, 25)
                .foregroundStyle(Color.LabelDisable)
            }
    }
}

#Preview {
    LocationPicker()
        .environmentObject(SignUpViewModel())
}
