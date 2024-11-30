//
//  HospitalCell.swift
//  babya
//
//  Created by hyk on 11/28/24.
//

import SwiftUI

struct HospitalCell: View {
    let name: String
    let category: String
    let tel: String
    let distance: String
    let address: String
    let x: String
    let y: String
    @State var showAlert: Bool = false
    
    var body: some View {
        Button {
            let encodedY = y.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                let encodedX = x.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                let kakaoURLString = "kakaomap://look?p=\(encodedY),\(encodedX)"
                let appStoreURL = URL(string: "https://apps.apple.com/kr/app/%EC%B9%B4%EC%B9%B4%EC%98%A4%EB%A7%B5-%EB%8C%80%ED%95%9C%EB%AF%BC%EA%B5%AD-no-1-%EC%A7%80%EB%8F%84%EC%95%B1/id304608425")

                if let kakaoURL = URL(string: kakaoURLString) {
                    if UIApplication.shared.canOpenURL(kakaoURL) {
                        UIApplication.shared.open(kakaoURL)
                    } else {
                        self.showAlert = true
                    }
                } else {
                    self.showAlert = true
                }
        } label: {
            VStack(spacing: 0) {
                Group {
                    Rectangle()
                        .frame(height: 93)
                        .foregroundStyle(.white)
                        .overlay {
                            VStack {
                                HStack(spacing: 15) {
                                    Text(name)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundStyle(.black)
                                    
                                    Text(category)
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundStyle(Color.LabelAssistive)
                                    
                                    Spacer()
                                }
                                
                                HStack(spacing: 1) {
                                    Text("TEL:")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundStyle(.black)
                                        .padding(.trailing, 10)
                                    
                                    Circle()
                                        .frame(width: 5, height: 5)
                                        .foregroundStyle(Color.ComponentFillAlternative)
                                    
                                    Text(tel)
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundStyle(Color.LabelAssistive)
                                    
                                    Spacer()
                                }
                                
                                HStack(spacing: 15) {
                                    Text(distance == "" ? "알 수 없음" : convertMetersToKilometers(meters: Double(distance) ?? 0))
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundStyle(.black)
                                    
                                    Text(address)
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundStyle(Color.black)
                                    
                                    Spacer()
                                }
                            }
                        }
                    
                    Divider()
                        .foregroundStyle(Color.LineNeutral)
                }
                .padding(.horizontal, 25)
            }
        }
        .alert("카카오맵을 설치해주세요.", isPresented: $showAlert) {
            Button("확인", role: .cancel) {
                
            }
        }
    }
    
    func convertMetersToKilometers(meters: Double) -> String {
        let kilometers = meters / 1000
        return String(format: "%.1f", kilometers) + "km"
    }
}

#Preview {
    HospitalCell(name: "병원", category: "산부인과", tel: "010-8262-2620", distance: "멀어요", address: "우리집", x: "", y: "")
}
