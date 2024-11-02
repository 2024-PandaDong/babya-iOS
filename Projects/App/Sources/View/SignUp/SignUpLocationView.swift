import SwiftUI

struct SignUpLocationView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: SignUpViewModel
    
    let columns: [GridItem] = [
        GridItem(.flexible(), alignment: .leading),
        GridItem(.flexible(), alignment: .leading),
        GridItem(.flexible(), alignment: .leading)
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("지역을 선택해주세요.")
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(LocalCode.allCases, id: \.self) { item in
                    Button {
                        withAnimation {
                            viewModel.selectedState = item
                        }
                    } label: {
                        Capsule()
                            .frame(width: viewModel.calculateWidth(for: item.name), height: 25)
                            .foregroundStyle(.clear)
                            .overlay {
                                Capsule().stroke(viewModel.selectedState == item ? Color.PrimaryLight : .LineAlternative, lineWidth: 1.3)
                                
                                Text(item.name)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(viewModel.selectedState == item ? Color.PrimaryLight : .LineAlternative)
                            }
                    }
                }
            }
            .padding(.vertical)
            
            Text("군을 선택해주세요.")
            
            if let state = viewModel.selectedState, !state.country.isEmpty {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(Array(state.country.sorted(by: { $0.key < $1.key })), id: \.key) { (district, code) in
                        Button {
                            withAnimation {
                                viewModel.selectedDistrict = district
                                viewModel.model.locationCode = code // 클릭한 군/구의 코드로 설정
                            }
                        } label: {
                            Capsule()
                                .frame(width: viewModel.calculateWidth(for: district), height: 25)
                                .foregroundStyle(.clear)
                                .overlay {
                                    Capsule().stroke(viewModel.selectedDistrict == district ? Color.PrimaryLight : .LineAlternative, lineWidth: 1.3)
                                    
                                    Text(district)
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundStyle(viewModel.selectedDistrict == district ? Color.PrimaryLight : .LineAlternative)
                                }
                        }
                    }
                }
                .padding(.vertical)
            }
            
            Spacer()
            
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 320, height: 45)
                    .foregroundStyle(Color.PrimaryLight)
                    .overlay {
                        Text("검색하기")
                            .foregroundStyle(.white)
                    }
            }
        }
        .padding(.vertical)
        .font(.system(size: 16, weight: .semibold))
        .padding(.horizontal, 30)
    }
}

#Preview {
    SignUpLocationView()
        .environmentObject(SignUpViewModel())
}
