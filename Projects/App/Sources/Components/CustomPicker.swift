//
//  CustomPicker.swift
//  babya
//
//  Created by dgsw8th32 on 5/27/24.
//

import SwiftUI

enum CurrentTab {
    case before, after
}

struct CustomPicker: View {
    @State var currentTab: CurrentTab = .before
    @StateObject var viewModel = HomeViewModel()
    
    func changeView(currentTab: CurrentTab) -> AnyView {
        switch currentTab {
        case .before:
            return AnyView(Text("출산전"))
        case .after:
            return AnyView(Text("출산후"))
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text("출산전")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(self.currentTab == .before ? .black : .gray)
                    .onTapGesture {
                        withAnimation {
                            self.currentTab = .before
                            viewModel.getBanner(type: "1")
                        }
                    }
                
                Text("출산후")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(self.currentTab == .after ? .black : .gray)
                    .onTapGesture {
                        withAnimation {
                            self.currentTab = .after
                            viewModel.getBanner(type: "2")
                        }
                    }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
            Rectangle()
                .frame(width: 45, height: 2)
                .foregroundStyle(.yellow)
                .padding(.horizontal, 18)
                .offset(x: self.currentTab == .after ? 50 : 0)
            
            if self.currentTab == .before {
                TabView {
                    ForEach(0..<viewModel.bannerResponse.data.count, id: \.self) { index in
                        let fileURLString: String? = viewModel.bannerResponse.data[index].image?.url
                        let fileURL: URL? = fileURLString != nil ? URL(string: fileURLString!) : nil
                        
                        if fileURL != nil {
                            Link(destination: URL(string: viewModel.bannerResponse.data[index].url)!) {
                                AsyncImage(url: fileURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 355, height: 200)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1)
                                        }
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(height: 240)
                                .onAppear {
                                    print(fileURLString)

                                }
                            }
                        } else {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 355, height: 200)
                                .foregroundStyle(.white)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1)
                                    
                                    Text("이미지를 불러올 수 없어요")
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundStyle(.gray)
                                }
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .frame(width: UIScreen.main.bounds.width, height: 220)
            } else {
                TabView {
                    ForEach(0..<viewModel.bannerResponse.data.count, id: \.self) { index in
                        let fileURLString: String? = viewModel.bannerResponse.data[index].image?.url
                        let fileURL: URL? = fileURLString != nil ? URL(string: fileURLString!) : nil
                        
                        if fileURL != nil {
                            AsyncImage(url: fileURL) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 355, height: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1)
                                    }
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height: 240)
                            .onAppear {
                                print(fileURLString)

                            }
                        } else {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 355, height: 200)
                                .foregroundStyle(.white)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1)
                                    
                                    Text("이미지를 불러올 수 없어요")
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundStyle(.gray)
                                }
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .frame(width: UIScreen.main.bounds.width, height: 220)
            }
        }
        .onAppear {
            viewModel.getBanner(type: "1")
        }
    }
}

#Preview {
    HomeView()
}
