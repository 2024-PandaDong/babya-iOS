//
//  HospitalView.swift
//  babya
//
//  Created by hyk on 11/21/24.
//

import SwiftUI
import KakaoMapsSDK
import KakaoMapsSDK_SPM

struct HospitalView: View {
    @State var draw: Bool = false
    
    var body: some View {
        KakaoMapsView(draw: $draw)
            .onAppear {
                self.draw = true
            }
            .onDisappear {
                self.draw = false
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    HospitalView()
}
