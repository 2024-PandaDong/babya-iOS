//
//  CustomDivider.swift
//  babya
//
//  Created by dgsw8th61 on 8/26/24.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        VStack{
            
            Spacer()
            HStack(spacing: 3){
//                Path { path in
//                    path.move(to: CGPoint(x:18, y: 105))
//                    
//                    path.addLine(to: CGPoint(x: 170, y: 105))
//                }
//                .stroke()
//                .foregroundColor(Color.LabelAlternative)
                
                Text("or")
                    .font(.system(size: 14,weight: .semibold))
                    .foregroundColor(Color.LabelAlternative)
                    .offset(x: 0,y: 0)
                
//                Path { path in
//                    path.move(to: CGPoint(x: 18, y: 105))
//                    
//                    path.addLine(to: CGPoint(x: 170, y: 105))
//                }
//                .stroke()
//                .foregroundColor(Color.LabelAlternative)
//                
//                
            }
        }
    }
}
#Preview {
    CustomDivider()
}
