//
//  PostingView.swift
//  babya
//
//  Created by hyk on 6/6/24.
//

import SwiftUI

struct PostingView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = PostingViewModel()
    
    var today: Date = Date.now
    let dateFormatter: DateFormatter = {
        let date = DateFormatter()
        date.dateFormat = "yyyy.MM.dd"
        return date
    }()
    
    @State var category: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray)
                
                HStack(spacing: 3) {
                    Text("카테고리를 선택 해주세요")
                        .font(.system(size: 14))
                    
                    Spacer()
                    
                    Button {
                        viewModel.model.category = "1"
                        print("카테고리 : \(viewModel.model.category)")
                    } label: {
                        Circle()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(viewModel.model.category == "question" ? .yellow : .gray)
                            .overlay {
                                Image(systemName: "bubble.fill")
                                    .font(.system(size: 10))
                                    .foregroundStyle(.white)
                                    .overlay {
                                        Image(systemName: "bubble")
                                            .font(.system(size: 10))
                                            .foregroundStyle(.black)
                                    }
                            }
                    }
                    Text("질문")
                        .font(.system(size: 11, weight: .bold))
                    Spacer()
                        .frame(width: 5)
                    
                    Button {
                        viewModel.model.category = "2"
                        print("카테고리 : \(viewModel.model.category)")
                    } label: {
                        Circle()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(viewModel.model.category == "share" ? .yellow : .gray)
                            .overlay {
                                Image(systemName: "pin.fill")
                                    .font(.system(size: 10))
                                    .foregroundStyle(.white)
                                    .overlay {
                                        Image(systemName: "pin")
                                            .font(.system(size: 10))
                                            .foregroundStyle(.black)
                                    }
                            }
                    }
                    Text("공유")
                        .font(.system(size: 11, weight: .bold))
                    Spacer()
                        .frame(width: 5)
                    
                    Button {
                        viewModel.model.category = "3"
                        print("카테고리 : \(viewModel.model.category)")
                    } label: {
                        Circle()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(viewModel.model.category == "life" ? .yellow : .gray)
                            .overlay {
                                Image(systemName: "car.fill")
                                    .font(.system(size: 10))
                                    .foregroundStyle(.white)
                                    .overlay {
                                        Image(systemName: "car")
                                            .font(.system(size: 10))
                                            .foregroundStyle(.black)
                                    }
                            }
                    }
                    Text("일상")
                        .font(.system(size: 11, weight: .bold))
                }
                .padding(.horizontal, 20)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray)
                
                TextField("", text: $viewModel.model.title, prompt: Text("제목").font(.system(size: 20)).foregroundColor(.gray))
                    .padding(.horizontal, 20)
                    .tint(.yellow)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray)
                
                HStack {
                    ImagePickerBox(width: 135, height: 100)
                        .environmentObject(viewModel)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.vertical)
                
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $viewModel.model.content)
                        .foregroundColor(Color.black)
                        .tint(.yellow)
                        .font(.system(size: 20))
                        .lineSpacing(5)
                        .padding(.horizontal, 20)
                                    
                    if viewModel.model.content.isEmpty {
                        Text("내용입력")
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 12)
                    }
                }
            }
            
        }
        .navigationBarBackButtonHidden()
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
                Text("\(dateFormatter.string(from: today))")
                    .font(.system(size: 16, weight: .bold))
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.post()
                    self.presentationMode.wrappedValue.dismiss()
                    print(viewModel.model.params)
                    
                } label: {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 50, height: 25)
                        .foregroundStyle(viewModel.isAvailable ? Color(red: 255/255, green: 203/255, blue: 41/255) : .gray)
                        .overlay {
                            Text("등록")
                                .foregroundStyle(.white)
                                .font(.system(size: 15, weight: .bold))
                        }
                }
                .disabled(!viewModel.isAvailable)
            }
        }
    }
}

#Preview {
    NavigationView {
        PostingView()
    }
}
