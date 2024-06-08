//
//  DiaryWritingView.swift
//  babya
//
//  Created by dgsw8th61 on 6/8/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI
struct DiaryWritingView : View {
    @State var lock : Bool = true
    @State var title : String
    var PostName : String
    var DiaryImage : String
    @State var weight: String = ""
    @State var weeks : String = ""
    @State var Opinion : String = ""
    @State var BloodPressure1 : String = ""
    @State var BloodPressure2 : String = ""
    @State var Content : String = ""
    @State private var selectedEmotion: Emotion? = nil
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @FocusState private var isTextFieldFocused: Bool
    @State private var nextSelectedDate = Date()
    @State var selectedDateTitle : Bool = false
    @State private var selectedDate = Date() {
        didSet {
            updateFormattedDate()
        }
    }
    @State private var showingDatePicker = false
    @State private var formattedDate = ""
    var body: some View {
        NavigationView{
            ZStack{
                VStack(alignment:.leading,spacing: 5){
                    Text("제목")
                        .font(.system(size: 20))
                        .bold()
                    
                    LineTextField(text: $title, TextFieldWidth: .infinity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.isTextFieldFocused = true
                            }
                        }
                        .overlay(alignment: .topLeading) {
                            Text("제목")
                                .font(.system(size: 14))
                                .foregroundStyle(title.isEmpty ? .gray : .clear)
                        }
                    
                    HStack{
                        Text("산모의 상태")
                            .font(.system(size: 20))
                            .bold()
                        Spacer()
                        Text("공개여부")
                            .font(.system(size: 20))
                            .bold()
                        Button(action: {
                            lock.toggle()
                        }, label: {
                            Image(lock ? "lock" : "unlock")
                                .resizable()
                                .frame(width: 18,height: 20)
                        })
                        .padding(.horizontal,5)
                    }
                    .padding(.vertical,15)
                    HStack{
                        VStack(alignment: .leading ,spacing: 10){
                            HStack(spacing:7){
                                Text("체중:")
                                    .font(.system(size: 16))
                                LineTextField(text: $weight, TextFieldWidth: 30)
                                Text("kg")
                                    .font(.system(size: 16))
                                    .padding(.trailing,30)
                                
                                Text("임신주수:")
                                    .font(.system(size: 16))
                                LineTextField(text: $weeks, TextFieldWidth: 30)
                                Text("주")
                                    .font(.system(size: 16))
                            }
                            HStack(spacing:7){
                                Text("혈압:")
                                    .font(.system(size: 16))
                                LineTextField(text: $BloodPressure1, TextFieldWidth: 30)
                                Text("/")
                                    .font(.system(size: 16))
                                LineTextField(text: $BloodPressure2, TextFieldWidth: 30)
                                    .padding(.trailing,30)
                                
                                Text("다음 진찰일:")
                                    .font(.system(size: 16))
                                Button(action: {
                                    self.showingDatePicker.toggle()
                                    selectedDateTitle = false
                                }) {
                                    Image("calendar")
                                        .resizable()
                                        .frame(width: 18, height: 20)
                                }
                            }
                            .padding(.bottom,15)
                            
                            Text("오눌 기분은?")
                                .font(.system(size: 20))
                                .bold()
                            HStack(spacing: 30) {
                                ForEach(Emotion.allCases, id: \.self) { emotion in
                                    IconButtons(emotion: emotion, isSelected: selectedEmotion == emotion) { selected in
                                        selectedEmotion = selected
                                    }
                                }
                            }
                            .padding(.bottom, 15)
                            
                            Text("태아소견")
                                .font(.system(size: 20))
                                .bold()
                            
                            LineTextField(text: $title, TextFieldWidth: .infinity)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        self.isTextFieldFocused = true
                                    }
                                }
                                .overlay(alignment: .topLeading) {
                                    Text("아이의 상태는 어떤가요?")
                                        .font(.system(size: 14))
                                        .foregroundStyle(title.isEmpty ? .gray : .clear)
                                }
                                .padding(.bottom,15)
                            
                            
                            Text("내용")
                                .font(.system(size: 20))
                                .bold()
                            
                            LineTextField(text: $title, TextFieldWidth: .infinity)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        self.isTextFieldFocused = true
                                    }
                                }
                                .overlay(alignment: .topLeading) {
                                    Text("오늘은 어떤일이 있으셨나요?")
                                        .font(.system(size: 14))
                                        .foregroundStyle(title.isEmpty ? .gray : .clear)
                                }
                                .padding(.bottom,15)
                            Text("사진추가")
                                .font(.system(size: 20))
                                .bold()
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 1.5)
                                .frame(width: 100, height: 100)
                                .background(.white)
                                .overlay {
                                    Image("camera")
                                }
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .padding(.horizontal,20)
                if showingDatePicker {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.showingDatePicker = false
                            selectedDateTitle = false
                            print(selectedDate)
                            print(nextSelectedDate)
                        }
                    DatePicker("Select Date", selection: selectedDateTitle ? $selectedDate : $nextSelectedDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }

                
                
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle(formattedDate)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("arrow")
                        .resizable()
                        .frame(width: 18,height: 18)
                }
            }
            
            ToolbarItem(placement:.navigationBarTrailing) {
                Button(action: {
                    self.showingDatePicker.toggle()
                    selectedDateTitle = true
                }) {
                    Image("calendar")
                        .resizable()
                        .frame(width: 18, height: 20)
                }
                Button(action: {
                    //
                }, label: {
                    Image("check")
                        .resizable()
                        .frame(width: 18,height: 18)
                })
            }
        }
        .onAppear {
            updateFormattedDate()
        }
        .onChange(of: selectedDateTitle) { newValue in
            if !newValue {
                updateFormattedDate()
            }
        }
    }
    private func updateFormattedDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formattedDate = formatter.string(from: selectedDate)
    }
}

#Preview {
    DiaryWritingView(title: "",PostName: "dsa",DiaryImage: "Image")
}
