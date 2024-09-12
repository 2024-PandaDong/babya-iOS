//
//  TodoCell.swift
//  babya
//
//  Created by hyk on 7/10/24.
//

import SwiftUI

struct TodoCell: View {
    let title: String
    @Binding var isChecked: Bool
    
    var action: () -> Void
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 350, height: 50)
            .foregroundStyle(.white)
            .overlay {
                HStack {
                    Button {
                        self.isChecked.toggle()
                        print(isChecked)
                        action()
                    } label: {
                        Circle()
                            .frame(width: 18, height: 18)
                            .foregroundStyle(isChecked ? Color.PrimaryLight :  .white)
                            .overlay {
                                Circle().stroke(.gray, lineWidth: 1)
                                
                                Image(systemName: "checkmark")
                                    .foregroundStyle(isChecked ? .white : .clear)
                                    .font(.system(size: 12, weight: .bold))
                            }
                    }
                    
                    Text(title)
                        .font(.system(size: 14, weight: .bold))
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .swipeActions(edge: .trailing) {
                Button(role: .destructive) {
                    
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
    }
}

struct SwipeAction<Content: View>: View {
    var cornerRadius: CGFloat = 0
    var direction: SwipeDirection = .trailing
    @ViewBuilder var content: Content
    @ActionBuilder var actions: [Action]
    let viewId = UUID()
    
    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    content
                        .containerRelativeFrame(.horizontal)
                        .id(viewId)
                    
                    ActionButtons {
                        withAnimation(.snappy) {
                            scrollProxy.scrollTo(viewId, anchor: direction == .trailing ? .topLeading : .topTrailing)
                        }
                    }
                }
                .scrollTargetLayout()
                .visualEffect { content, geometryProxy in
                    content
                        .offset(x: scrollOffset(geometryProxy))
                }
            }
            .frame(height: 50)
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .clipShape(.rect(cornerRadius: cornerRadius))
        }
    }
    
    @ViewBuilder
    func ActionButtons(resetPosition: @escaping () -> ()) -> some View {
        Rectangle()
            .fill(.clear)
            .frame(width: CGFloat(actions.count) * 50, height: 50)
            .overlay {
                HStack(spacing: 0) {
                    ForEach(actions) { button in
                        Button {
                            Task {
                                resetPosition()
                                try? await Task.sleep(for: .seconds(0.25))
                                button.action()
                            }
                        } label: {
                            Image(systemName: button.icon)
                                .foregroundStyle(.white)
                                .frame(width: 50)
                                .frame(maxHeight: .infinity)
                                .contentShape(.rect)
                        }
                        .background(button.tint)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
    }
    
    func scrollOffset(_ proxy: GeometryProxy) -> CGFloat  {
        let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
        
        return direction == .trailing ? (minX > 0 ? -minX : 0) : (minX < 0 ? -minX : 0)
    }
}

enum SwipeDirection {
    case leading
    case trailing
    
    var alignment: Alignment {
        switch self {
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        }
    }
}

struct Action: Identifiable {
    private(set) var id: UUID = .init()
    var tint: Color
    var icon: String
    var iconFont: Font = .title
    var iconTint: Color = .white
    var isEnabled: Bool = true
    var action: () -> ()
}

@resultBuilder
struct ActionBuilder {
    static func buildBlock(_ components: Action...) -> [Action] {
        return components
    }
}

#Preview {
    ZStack {
        Color.black
        
        TodoCell(title: "동바오동바오", isChecked: .constant(false)) {
            
        }
    }
}
