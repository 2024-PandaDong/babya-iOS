//
//  TodoListView.swift
//  babya
//
//  Created by hyk on 6/27/24.
//

import SwiftUI

struct TodoListView: View {
    @Environment(\.presentationMode) var presentationMode
    
    
    @State var isClick: Bool = false
    @State var isEditing: Bool = false
    
    @EnvironmentObject var viewModel: TodoViewModel
    
    var body: some View {
        ZStack {
            Color(red: 245/255, green: 245/255, blue: 245/255)
            
            VStack {
                ScrollView(.horizontal) {
                    Spacer()
                        .frame(height: 110)
                    
                    HStack {
                        Button {
                            viewModel.changeCategory()
                        } label: {
                            Capsule()
                                .frame(width: 53, height: 23)
                                .foregroundStyle(viewModel.currentTab == "" ? Color.yellow0 : .gray)
                                .overlay {
                                    Text("전체")
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundStyle(.white)
                                }
                        }
                        
                        ForEach(0..<viewModel.categoryResponse.data.category.count, id: \.self) { index in
                            Button {
                                viewModel.changeCategory(currentTab: viewModel.categoryResponse.data.category[index])

                            } label: {
                                Capsule()
                                    .frame(width: 53, height: 23)
                                    .foregroundStyle(viewModel.currentTab == viewModel.categoryResponse.data.category[index] ? Color.yellow0 : .gray)
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
                
                ScrollView {
                    HStack {
                        VStack(alignment: .leading) {
                            if viewModel.todoResponse != nil {
                                ForEach(viewModel.uniqueDates, id: \.self) { date in
                                    let dateComponents = date.split(separator: "-")
                                    let month = dateComponents[1]
                                    let day = dateComponents[2]
                                    
                                    if let todoItems = viewModel.todoResponse.data?.filter({ $0.planedDt == date }) {
                                        VStack(alignment: .leading) {
                                            Text("\(month)월 \(day)일")
                                                .font(.headline)
                                                                                    
                                            ForEach(todoItems, id: \.self) { item in
                                                SwipeAction(cornerRadius: 10, direction: .trailing) {
                                                    TodoCell(title: item.content, isChecked: item.isChecked) {
                                                        viewModel.todoCheck(isChecked: item.isChecked, id: item.todoId)
                                                        print(item.todoId)
                                                    }
                                                } actions: {
                                                    Action(tint: Color.yellow0, icon: "square.and.pencil") {
                                                        print("modify")
                                                        self.isEditing = true
                                                    }
                                                    Action(tint: .red, icon: "trash.fill") {
                                                        print("delete")
                                                        viewModel.deleteTodo(id: item.todoId)
                                                    }
                                                }
                                                .sheet(isPresented: $isEditing) {
                                                    TodoModifyView()
                                                }
                                            }
                                        }
                                        .padding()
                                    }
                                }
                            } else {
                                Text("할 일이 존재하지 않아요")
                            }
                        }
                        
                        Spacer()
                    }
                }
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
            viewModel.changeCategory()
        }
    }
}

#Preview {
    NavigationView {
        TodoListView()
            .environmentObject(TodoViewModel())
    }
}
