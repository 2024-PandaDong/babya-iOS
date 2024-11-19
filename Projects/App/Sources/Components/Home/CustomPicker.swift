//
//  CustomPicker.swift
//  babya
//
//  Created by dgsw8th32 on 5/27/24.
//

import SwiftUI
import Kingfisher

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
    
    init() {
        // 현재 페이지 표시 색상
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color.PrimaryLight)
        // 다른 페이지 표시 색상
        UIPageControl.appearance().pageIndicatorTintColor = .white
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
//            HStack {
//                Text("출산전")
//                    .font(.system(size: 16, weight: .bold))
//                    .foregroundStyle(self.currentTab == .before ? .black : .gray)
//                    .onTapGesture {
//                        withAnimation {
//                            self.currentTab = .before
//                            viewModel.getBanner(type: "1")
//                        }
//                    }
//                
//                Text("출산후")
//                    .font(.system(size: 16, weight: .bold))
//                    .foregroundStyle(self.currentTab == .after ? .black : .gray)
//                    .onTapGesture {
//                        withAnimation {
//                            self.currentTab = .after
//                            viewModel.getBanner(type: "2")
//                        }
//                    }
//                
//                Spacer()
//            }
//            .padding(.horizontal, 20)
//            
//            Rectangle()
//                .frame(width: 45, height: 2)
//                .foregroundStyle(Color.PrimaryLight)
//                .padding(.horizontal, 18)
//                .offset(x: self.currentTab == .after ? 50 : 0)
            
            TabView {
                ForEach(0..<viewModel.bannerResponse.data.count, id: \.self) { index in
                    let fileURLString: String? = viewModel.bannerResponse.data[index].image?.url
                    let fileURL: URL? = fileURLString != nil ? URL(string: fileURLString!) : nil
                    
                    if fileURL != nil {
                        Link(destination: URL(string: viewModel.bannerResponse.data[index].url)!) {
//                            AsyncImage(url: URL(string: fileURLString ?? "")) { image in
//                                image
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(maxWidth: .infinity, minHeight: 250, maxHeight: 250)
//                            } placeholder: {
//                                ProgressView()
//                            }
//                            .frame(height: 250)
                            KFImage(URL(string: fileURLString ?? ""))
                                .placeholder {
                                    ProgressView()
                                }
                                .setProcessor(DownsamplingImageProcessor(size: CGSize(width: 500, height: 500)))
                                .cacheMemoryOnly()
                                .fade(duration: 0.25)
                                .resizable()
                                .frame(maxWidth: .infinity, minHeight: 250, maxHeight: 250)
                                .aspectRatio(contentMode: .fill)
                        }
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 355, height: 200)
                            .foregroundStyle(.white)
                            .overlay {
                                Text("이미지를 불러올 수 없어요")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundStyle(.gray)
                            }
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle())
            .frame(width: UIScreen.main.bounds.width, height: 230)
        }
        .onAppear {
            viewModel.getBanner(type: "1")
        }
    }
}

#Preview {
    CustomPicker()
}
