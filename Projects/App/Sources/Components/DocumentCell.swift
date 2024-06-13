//
//  DocumentCell.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI

struct DocumentCell: View {
    let image: String
    let title: String
    
    init(image: String, title: String) {
        self.image = image
        self.title = title
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 100, height: 100)
            .foregroundStyle(.white)
            .overlay {
                VStack(spacing: 5) {
                    Image(systemName: "\(image)")
                        .font(.system(size: 50, weight: .light))
                    
                    Text(title)
                        .font(.system(size: 12))
                }
            }
    }
}

#Preview {
    DocumentCell(image: "doc", title: "개인정보약관 상세")
        .padding()
        .background(Color.black)
}
