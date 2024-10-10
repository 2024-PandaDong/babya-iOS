//
//  WelfareInfoView.swift
//  babya
//
//  Created by dgsw8th61 on 10/10/24.
//

import Foundation
import SwiftUI

import SwiftUI

struct WelfareInfoView: View {
    var title: String
    var value: Any?

    var body: some View {
        if let value {
            let displayValue = "\(value)"
            infoLayout(text1: title, text2: displayValue)
        }
    }
}

