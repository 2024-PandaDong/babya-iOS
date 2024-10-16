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
    static let gray3 = Color(hex: "#ACACAC")
    static let ivory = Color(hex: "f8ede3")
    static let brown = Color(hex: "897853")
    static let yellow0 = Color(hex: "#FFCB29")
    static let yellow1 = Color(hex: "#F6A723")
    static let red0 = Color(hex: "#FF4B4B")
    static let blue0 = Color(hex: "#7896FF")
    static let green0 = Color(hex: "#00DB1C")
    
    static let PrimaryLight = Color(hex: "FE9A99")
    static let PrimaryNormal = Color(hex:"FD7D7C")
    static let PrimaryStrong = Color(hex: "FF7170")
    static let PrimaryHeavy = Color(hex: "FF4E4D")
    static let LabelNormal = Color(hex: "0A0A0A")
    static let LabelStrong = Color(hex: "000000")
    static let LabelNeutral = Color(hex: "474747")
    static let LabelAlternative = Color(hex: "5C5C5C")
    static let LabelAssistive = Color(hex: "999999")
    static let LabelDisable = Color(hex: "C4C4C4")
    static let LabelLightDisable = Color(hex: "DCDCDC")
    static let BackgroundNormal = Color(hex: "FFFFFF")
    static let BackgroundStrong = Color(hex: "F7F7F7")
    static let BackgroundHeavy = Color(hex: "DCDCDC")
    static let BackgroundAlternative = Color(hex: "FFFFFF")
    static let BackgroundElevatedNormal = Color(hex: "FFFFFF")
    static let BackgroundElevatedAlternative = Color(hex: "F7F7F7")
    static let LineNormal = Color(hex: "DCDCDC")
    static let LineNeutral = Color(hex: "000000")
    static let LineAlternative = Color(hex: "ADADAD")
    static let AvatarIcon = Color(hex: "FD7D7C")
    static let AvatarBackground = Color(hex: "FE9A99")
    static let ComponentFillNormal = Color(hex: "FFFFFF")
    static let ComponentFillStrong = Color(hex: "F7F7F7")
    static let ComponentFillAlternative = Color(hex: "F7F7F7")
    static let ComponentMaterialDimmer = Color(hex: "DCDCDC")
    static let pink70 = Color(hex: "FFA7A6")
    static let blue70 = Color(hex: "69AEE3")
    static let Opacity35 = Color(hex: "A7A7A8")
    static let Blue60 = Color(hex: "53A3DF")
    static let Red60 = Color(hex: "FF4433")
    static let StatusPositive = Color(hex: "64CD32")
    static let StatusDestructive = Color(hex: "FF1600")
    static let StatusCautionary = Color(hex: "FFD600")
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


