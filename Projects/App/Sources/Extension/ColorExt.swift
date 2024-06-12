//
//  Color.swift
//  babya
//
//  Created by dgsw8th61 on 5/2/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

// ColorExtentsion.swift
import SwiftUI


extension Color {

    static let gray0 = Color(hex: "#f5f5f5")
    static let gray1 = Color(hex: "#989898")
    static let gray2 = Color(hex: "#D9D9D9")
    static let ivory = Color(hex: "f8ede3")
    static let brown = Color(hex: "897853")
    static let yellow0 = Color(hex: "#FFCB29")
    static let yellow1 = Color(hex: "#F6A723")
}

extension Color {
  init(hex: String) {
      let scanner = Scanner(string: hex)
         _ = scanner.scanString("#")
         
         var rgb: UInt64 = 0
         scanner.scanHexInt64(&rgb)
         
         let r = Double((rgb >> 16) & 0xFF) / 255.0
         let g = Double((rgb >>  8) & 0xFF) / 255.0
         let b = Double((rgb >>  0) & 0xFF) / 255.0
         self.init(red: r, green: g, blue: b)

      
  }
}


