//
//  PostCell.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI

struct PostCell: View {
    var body: some View {
        VStack {
            HStack {
                Capsule()
                    .frame(width: 50, height: 15)
                    .foregroundStyle(Color(red: 255/255, green: 227/255, blue: 139/255))
                    .overlay {
                        Text("3/27")
                            .font(.system(size: 12))
                            .foregroundStyle(Color(red: 255/255, green: 138/255, blue: 0/255))
                    }
                
                Capsule()
                    .frame(width: 50, height: 15)
                    .foregroundStyle(.white)
                    .overlay {
                        Capsule().stroke(.gray)
                        
                        HStack {
                            Image(systemName: "eye.fill")
                                .font(.system(size: 10))
                            
                            Text("154")
                                .font(.system(size: 10))
                        }
                    }
                
                Capsule()
                    .frame(width: 50, height: 15)
                    .foregroundStyle(.white)
                    .overlay {
                        Capsule().stroke(.gray)
                        
                        HStack {
                            Image(systemName: "bubble")
                                .font(.system(size: 10))
                            
                            Text("12")
                                .font(.system(size: 10))
                        }
                    }
                
                Spacer()
            }
            
            HStack {
                Text("임산부한테 좋은 약 알려주세요.")
                
                Spacer()
                
                NavigationLink(destination: Text("게시물")) {
                    Image(systemName: "arrow.right")
                        .foregroundStyle(.black)
                }
            }
            
            Rectangle()
                .frame(width: 320, height: 1)
                .foregroundStyle(.gray)
        }
        .padding(.horizontal, 50)
        .padding(.vertical, 5)
    }
}

#Preview {
    PostCell()
}
