//
//  NoticeBoardView.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI

struct NoticeBoardView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = NoticeBoardViewModel()
    
    let category: [String : String] = [
        "질문" : "1",
        "공유" : "2",
        "일상" : "3"
    ]
    @State var selectedCategory: String = "1"
    @State var showCategoryPicker: Bool = false
    
    var body: some View {
        ZStack {
                ScrollView {
                    Rectangle()
                        .frame(height: 110)
                        .foregroundStyle(Color(red: 255/255, green: 203/255, blue: 41/255))
                        .overlay {
                            HStack(spacing: 40) {
                                Text("오늘도 따뜻한 가정을 위해\n애기야에서 이야기 나눠봐요")
                                    .font(.system(size: 20, weight: .bold))
                                
                                Image("duck")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .offset(x: 0, y: 15)
                            }
                        }
                    
                    ForEach(0..<viewModel.model.data.count, id: \.self) { index in
                        PostPreviewCell(model: viewModel.model, index: index)
                    }
                    
                    Spacer()
                        .frame(height: 100)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.black)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("게시판")
                        .font(.system(size: 20, weight: .bold))
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("", selection: $selectedCategory) {
                            ForEach(Array(category.keys), id: \.self) { key in
                                Text(key).tag(category[key] ?? "")
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .foregroundStyle(.black)
                    }
                    .onChange(of: selectedCategory) { newValue in
                        viewModel.getPosts(page: 1, size: 25, category: newValue)
                        print()
                    }
                }
            }
            
            VStack {
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    NavigationLink(destination: PostingView()) {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(Color(red: 255/255, green: 203/255, blue: 41/255))
                            .overlay {
                                Image(systemName: "pencil")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 25))
                            }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 30)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.getPosts(page: 1, size: 25, category: "1")
        }
    }
}

#Preview {
    NavigationView {
        NoticeBoardView()
    }
}
