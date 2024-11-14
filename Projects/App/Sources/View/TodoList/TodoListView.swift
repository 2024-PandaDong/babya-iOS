import SwiftUI
import FlowKit

struct TodoListView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isClick: Bool = false
    @State private var isEditing: Bool = false
    @State private var editingContent: String = ""
    @State private var editingTodoId: Int = 0
    @State private var editingCategory: String = ""
    @State private var editingPlanedDt: String = ""
    @State private var isCheck: Bool = false
    @State private var expandedDates: Set<String> = []
    
    @Flow var flow
    @StateObject var viewModel = TodoViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView(.horizontal) {
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
                        .padding(.leading)
                        
                        ForEach(viewModel.categoryResponse.data.category.indices, id: \.self) { index in
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
                    .frame(height: 26)
                }
                .padding(.top, 50)
                .padding(.bottom, -20)
                
                ScrollView {
                    if !viewModel.todoResponse.data.isEmpty {
                        VStack(spacing: 0) {
                            ForEach(viewModel.uniqueDates, id: \.self) { date in
                                let dateComponents = date.split(separator: "-")
                                let day = dateComponents[2]
                                
                                Rectangle()
                                    .foregroundStyle(.clear)
                                    .frame(height: 3)
                                
                                Button {
                                    withAnimation {
                                        if expandedDates.contains(date) {
                                            expandedDates.remove(date)
                                        } else {
                                            expandedDates.insert(date)
                                        }
                                    }
                                } label: {
                                    HStack {
                                        Text("\(day)일")
                                            .font(.headline)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.down")
                                            .rotationEffect(.degrees(expandedDates.contains(date) ? 180 : 0))
                                    }
                                    .frame(height: 40)
                                    .tint(.black)
                                    .padding(.horizontal)
                                }
                                .background(Color.white)
                                
                                if expandedDates.contains(date) {
                                    ForEach($viewModel.todoResponse.data, id: \.self) { $item in
                                        if $item.planedDt.wrappedValue == date {
                                            SwipeAction(cornerRadius: 0, direction: .trailing) {
                                                TodoCell(title: $item.content.wrappedValue, isChecked: $item.isChecked) {
                                                    viewModel.todoCheck(isChecked: $item.isChecked.wrappedValue, id: $item.todoId.wrappedValue)
                                                }
                                            } actions: {
                                                Action(tint: Color.yellow0, icon: "square.and.pencil") {
                                                    self.editingContent = item.content
                                                    self.editingTodoId = item.todoId
                                                    self.editingCategory = item.category
                                                    self.editingPlanedDt = item.planedDt
                                                    self.isEditing = true
                                                }
                                                Action(tint: .red, icon: "trash.fill") {
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
                            }
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
                .background(Color(red: 245/255, green: 245/255, blue: 245/255))
                .padding(.top)
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
                    .padding(.vertical, 50)
                }
                .sheet(isPresented: $isClick) {
                    TodoPostView(category: $viewModel.model.category, content: $viewModel.model.content, planedDt: $viewModel.model.planedDt) {
                        viewModel.postTodo()
                    }
                    .environmentObject(viewModel)
                }
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    flow.pop()
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
        .ignoresSafeArea(.all)
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
