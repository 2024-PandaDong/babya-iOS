//
//  ViewExt.swift
//  babya
//
//  Created by dgsw8th32 on 5/7/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

extension View {
    
    func nextButton(title: String, destination: some View, action: (() -> ())? = nil, disable: Bool = false) -> some View {
        
        NextButton(
            title: title,
            content: {
                AnyView(self)
            },
            destination: {
                AnyView(destination)
            }, action: {
            if let action = action  {
                action()
            }
            else {
                // noaction
            }
        }, disable: disable)
    }
    
}
