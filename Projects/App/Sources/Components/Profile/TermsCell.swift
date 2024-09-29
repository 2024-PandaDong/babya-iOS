import SwiftUI
import WebKit

struct TermsCell: View {
    let title: String
    let link: String
    let isLast: Bool
    @State var isClicked: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Button {
                self.isClicked = true
            } label: {
                Rectangle()
                    .frame(height: 60)
                    .foregroundStyle(.white)
                    .overlay {
                        HStack {
                            Text(title)
                                .foregroundStyle(.black)
                                .font(.system(size: 16, weight: .medium))
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color.LineNormal)
                        }
                        .padding(.horizontal, 25)
                    }
            }
            
            if !isLast {
                Divider()
            }
        }
        .sheet(isPresented: $isClicked) {
            WebViewer(url: link)
        }
    }
}

#Preview {
    ZStack {
        Color.PrimaryLight
        
        TermsCell(title: "프로필 수정", link: "https://github.com/lsh1202", isLast: false)
    }
}
