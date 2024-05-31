//
//  ViewExt.swift
//  babya
//
//  Created by dgsw8th32 on 5/7/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

extension View {
    
    func customTabBar() -> some View {
        
        CustomTabBar(
            content: {
                AnyView(self)
            }
        )
    }
    
}
