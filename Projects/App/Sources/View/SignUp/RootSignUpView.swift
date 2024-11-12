//
//  RootSignUpView.swift
//  babya
//
//  Created by hyk on 10/31/24.
//

import SwiftUI
import FlowKit

struct RootSignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = SignUpViewModel()
    @Flow var flow
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            
            HStack {
                Rectangle()
                    .foregroundStyle(Color.PrimaryNormal)
                    .frame(
                        width: viewModel.pageNum == 0 ? 5 :
                            viewModel.pageNum == 1 ? 80 :
                            viewModel.pageNum == 2 ? 160 :
                            viewModel.pageNum == 3 ? 240 :
                            viewModel.pageNum == 4 ? 320 : 400,
                        height: 2
                    )
                
                Spacer()
            }
            
            if viewModel.pageNum == 0 {
                FirstSignUpView()
                    .environmentObject(viewModel)
            } else if viewModel.pageNum == 1 {
                SecondSignUpView()
                    .environmentObject(viewModel)
            } else if viewModel.pageNum == 2 {
                ThirdSignUpView()
                    .environmentObject(viewModel)
            } else if viewModel.pageNum == 3 {
                FourthSignUpView()
                    .environmentObject(viewModel)
            } else if viewModel.pageNum == 4 {
                FifthSignUpView()
                    .environmentObject(viewModel)
            } else if viewModel.pageNum == 5 {
                FinalSignUpView()
                    .environmentObject(viewModel)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    if viewModel.pageNum == 0 {
                        self.presentationMode.wrappedValue.dismiss()
//                        flow.pop()
                    } else {
                        withAnimation {
                            if viewModel.isPlaning {
                                viewModel.pageNum -= 2
                                viewModel.isPlaning = false
                            } else {
                                viewModel.pageNum -= 1
                            }
                            viewModel.width -= 80
                        }
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.black)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Text("\(viewModel.pageNum == 0 ? 0 : viewModel.pageNum == 1 ? 20 : viewModel.pageNum == 2 ? 40 : viewModel.pageNum == 3 ? 60 : viewModel.pageNum == 4 ? 80 : 100)%")
                    .foregroundStyle(.black)
                    .font(.system(size: 12))
            }
        }
    }
}

#Preview {
    NavigationView {
        RootSignUpView()
    }
}
