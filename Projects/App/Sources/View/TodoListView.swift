//
//  TodoListView.swift
//  babya
//
//  Created by hyk on 6/27/24.
//

import SwiftUI

struct TodoListView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var dateFormatter = DateFormatter()
    
    @State var isClick: Bool = false
    @State var currentTab: String = ""
    @EnvironmentObject var viewModel: TodoViewModel
    @State var date: Date = Date.now
    
    init() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    var body: some View {
        ZStack {
            Color(red: 245/255, green: 245/255, blue: 245/255)
            
            ScrollView {
                Spacer()
                    .frame(height: 110)
                
                ScrollView(.horizontal) {
                    HStack {
                        Button {
                            currentTab = ""
                        } label: {
                            Capsule()
                                .frame(width: 53, height: 23)
                                .foregroundStyle(currentTab == "" ? Color.yellow0 : .gray)
                                .overlay {
                                    Text("전체")
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundStyle(.white)
                                }
                        }
                        
                        ForEach(0..<viewModel.categoryResponse.data.category.count, id: \.self) { index in
                            Button {
                                currentTab = viewModel.categoryResponse.data.category[index]
                                print(currentTab)
                            } label: {
                                Capsule()
                                    .frame(width: 53, height: 23)
                                    .foregroundStyle(currentTab == viewModel.categoryResponse.data.category[index] ? Color.yellow0 : .gray)
                                    .overlay {
                                        Text(viewModel.categoryResponse.data.category[index])
                                            .font(.system(size: 15, weight: .bold))
                                            .foregroundStyle(.white)
                                    }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            HStack {
                Spacer()
                
                VStack {
                    Spacer()
                    
                    Button {
                        self.isClick = true
                    } label: {
                        Circle()
                            .foregroundStyle(Color.yellow0)
                            .frame(width: 50, height: 50)
                            .overlay {
                                Image(systemName: "plus")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 30))
                            }
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 50)
                }
                .sheet(isPresented: $isClick) {
                    TodoPostView(category: $viewModel.model.category, content: $viewModel.model.content, planedDt: $viewModel.model.planedDt){
                        viewModel.postTodo()
                    }
                    .environmentObject(viewModel)
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
                Text("투두리스트")
                    .font(.system(size: 20, weight: .bold))
            }
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.getCategory()
            viewModel.getTodo(category: "", date: dateFormatter.string(from: date))
        }
    }
}

#Preview {
    NavigationView {
        TodoListView()
            .environmentObject(TodoViewModel())
    }
}
