//
//  FourthSignUpView.swift
//  babya
//
//  Created by hyk on 9/12/24.
//

import SwiftUI

struct FourthSignUpView: View {
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var viewModel: SignUpViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                Divider()
                
                Rectangle()
                    .frame(width: geometry.size.width / 1.5, height: 2)
                    .foregroundStyle(Color.PrimaryNormal)
                
                Group {
                    Text("당신은 현재...")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.top, 40)
                    
                    NavigationLink(destination: FinalSignUpView().environmentObject(viewModel)) {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(maxWidth: .infinity, maxHeight: 55)
                            .foregroundStyle(.white)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.LineAlternative)
                                
                                HStack(spacing: 20) {
                                    Image("planing")
                                    
                                    Text("임신을 계획하고 있어요!")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(.black)
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 25)
                            }
                    }
                    
                    AboutMyPregnancyCell(image: "inPregnancy", title: "  임신중이에요!") {
                        viewModel.familyType = 2
                    }
                    
                    AboutMyPregnancyCell(image: "hasBaby", title: "  귀여운 아기가 있어요!") {
                        viewModel.familyType = 3
                    }
                    
                    AboutMyPregnancyCell(image: "withFamily", title: "귀여운 아이, 태아 모두 있어요!") {
                        viewModel.familyType = 4
                    }
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.black)
                            .fontWeight(.medium)
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .gesture(DragGesture().updating($dragOffset) { (value, state, transaction) in
                if (value.startLocation.x < 30 && value.translation.width > 100) {
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

#Preview {
    NavigationView {
        FourthSignUpView()
            .environmentObject(SignUpViewModel())
    }
}
