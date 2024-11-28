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
    let id: String
    
    var body: some View {
        Button {
            let url = URL(string: "kakaomap://place?id=\(id)")!
            let appStoreURL = URL(string: "https://apps.apple.com/kr/app/%EC%B9%B4%EC%B9%B4%EC%98%A4%EB%A7%B5-%EB%8C%80%ED%95%9C%EB%AF%BC%EA%B5%AD-no-1-%EC%A7%80%EB%8F%84%EC%95%B1/id304608425")!
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url) // 카카오맵으로 이동
            } else {
                UIApplication.shared.open(appStoreURL) // 카카오맵 미설치 시 앱스토어로 이동
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
                                    Text(convertMetersToKilometers(meters: Double(distance) ?? 0))
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
    }
    
    func convertMetersToKilometers(meters: Double) -> String {
        let kilometers = meters / 1000
        return String(format: "%.1f", kilometers) + "km"
    }
}

#Preview {
    HospitalCell(name: "병원", category: "산부인과", tel: "010-8262-2620", distance: "멀어요", address: "우리집", id: "ddd")
}
