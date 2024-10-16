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
    @State private var editingContent: String = ""
    @State private var editingTodoId: Int = 0
    @State private var editingCategory: String = ""
    @State private var editingPlanedDt: String = ""
    @State private var isCheck: Bool = false
    
    @StateObject var viewModel = TodoViewModel()
    
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
                                .frame(width: 46, height: 25)
                                .foregroundStyle(.clear)
                                .overlay {
                                    Text("전체")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundStyle(viewModel.currentTab == "" ? Color.PrimaryLight : .black)
                                    
                                    Capsule().stroke(viewModel.currentTab == "" ? Color.PrimaryLight : .gray)
                                }
                        }
                        
                        ForEach(0..<viewModel.categoryResponse.data.category.count, id: \.self) { index in
                            Button {
                                viewModel.changeCategory(currentTab: viewModel.categoryResponse.data.category[index])
                                
                            } label: {
                                Capsule()
                                    .frame(width: 46, height: 25)
                                    .foregroundStyle(.clear)
                                    .overlay {
                                        Text(viewModel.categoryResponse.data.category[index])
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundStyle(viewModel.currentTab == viewModel.categoryResponse.data.category[index] ? Color.PrimaryLight : .black)
                                        
                                        Capsule().stroke(viewModel.currentTab == viewModel.categoryResponse.data.category[index] ? Color.PrimaryLight : .gray)
                                    }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                ScrollView {
                    HStack {
                        VStack(alignment: .leading) {
                            if viewModel.todoResponse.data != [] {
                                
                                ForEach(viewModel.uniqueDates, id: \.self) { date in
                                    let dateComponents = date.split(separator: "-")
                                    let month = dateComponents[1]
                                    let day = dateComponents[2]
                                    
                                    
                                    VStack(alignment: .leading) {
                                        Text("\(month)월 \(day)일")
                                            .font(.headline)
                                        
                                        
                                        
                                        ForEach($viewModel.todoResponse.data, id: \.self) { $item in
                                            if $item.planedDt.wrappedValue == date {
                                                SwipeAction(cornerRadius: 10, direction: .trailing) {
                                                    TodoCell(title: $item.content.wrappedValue, isChecked: $item.isChecked) {
                                                        viewModel.todoCheck(isChecked: $item.isChecked.wrappedValue, id: $item.todoId.wrappedValue)
                                                    }
                                                } actions: {
                                                    Action(tint: Color.yellow0, icon: "square.and.pencil") {
                                                        print("modify")
                                                        self.editingContent = item.content
                                                        self.editingTodoId = item.todoId
                                                        self.editingCategory = item.category
                                                        self.editingPlanedDt = item.planedDt
                                                        self.isEditing = true
                                                    }
                                                    Action(tint: .red, icon: "trash.fill") {
                                                        print("delete")
                                                        viewModel.deleteTodo(id: item.todoId)
                                                    }
                                                }
                                                .sheet(isPresented: $isEditing) {
                                                    TodoModifyView(id: $editingTodoId, category: $editingCategory, content: $editingContent, planedDt: $editingPlanedDt) {
                                                        viewModel.editTodo(
                                                            id: editingTodoId,
                                                            category: editingCategory,
                                                            content: editingContent,
                                                            planedDt: editingPlanedDt
                                                        )
                                                        self.isEditing = false
                                                    }
                                                    .environmentObject(viewModel)
                                                }
                                            }
                                        }

                                    }
                                    .padding()
                                }
                            } else {
                                VStack(alignment: .center) {
                                    Spacer()
                                        .frame(height: 150)
                                    
                                    Image("baseTodoImage")
                                        .resizable()
                                        .scaledToFit()
                                    
                                    Text("할 일이 존재하지 않아요.")
                                        .font(.system(size: 20, weight: .bold))
                                }
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
                            .foregroundStyle(Color.PrimaryLight)
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
    }
}
