import SwiftUI
import RichText
import FlowKit

struct PolicyDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var policyVM = PolicyViewModel.shared
    @Flow var flow
    
    let index: Int
    
    var body: some View {
        ZStack {
            ScrollView {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 340, height: 130)
                    .foregroundStyle(.white)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10).stroke(Color.LineNormal)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(policyVM.policyDetailmodel.title)
                                    .font(.system(size: 20, weight: .semibold))
                                
                                Text(policyVM.policyDetailmodel.editDate)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(Color.LabelAssistive)
                                
                                if let state = policyVM.selectedState?.name {
                                    HStack(spacing: 5) {
                                        Text("시행기관:")
                                            .font(.system(size: 14, weight: .semibold))
                                        
                                        Text("\(state) \(policyVM.selectedDistrict) 보건소")
                                            .font(.system(size: 14, weight: .medium))
                                    }
                                }
                            }
                            Spacer()
                        }
                        .padding(20)
                    }
                    .padding(.vertical, 30)
                
                RichText(html: policyVM.policyDetailmodel.content)
                    .lineHeight(170)
                    .imageRadius(12)
                    .fontType(.system)
                    .colorScheme(.auto)
                    .linkOpenType(.Safari)
                    .linkColor(light: .blue, dark: .indigo)
                    .placeholder {
                        ProgressView()
                    }
                    .padding(.horizontal, 30)
                
                Rectangle()
                    .foregroundStyle(.clear)
                    .frame(height: 60)
            }
            
            VStack {
                Divider()
                    .padding(.top, -17)
                
                Spacer()
                
                if let url = URL(string: policyVM.policyDetailmodel.link) {
                    Link(destination: url) {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 320, height: 45)
                            .foregroundStyle(Color.PrimaryLight)
                            .overlay {
                                Text("내용이 더 궁금하다면?")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 14, weight: .bold))
                            }
                    }
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 320, height: 45)
                        .foregroundStyle(Color.ComponentFillAlternative)
                        .overlay {
                            Text("내용이 더 궁금하다면?")
                                .foregroundStyle(.white)
                                .font(.system(size: 14, weight: .bold))
                        }
                }
            }
            .padding(.vertical)
            
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    flow.pop()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.black)
                        .fontWeight(.medium)
                }
            }
        }
        .onAppear {
            policyVM.getPolicyDetail(index: index)
            print("index: \(index)")
        }
    }
}

#Preview {
    NavigationView {
        PolicyDetailView(index: 0)
    }
}
