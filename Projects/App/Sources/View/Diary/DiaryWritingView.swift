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
    @Environment(\.dismiss) private var dismiss
    @State private var privateToggle : Bool = false
    @State var weight: String = ""
    @State var weeks : String = ""
    @State var Opinion : String = ""
    @State var systolicPressure : String = ""
    @State var diastolicPressure : String = ""
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
    @State var complete : Bool = false
    @State private var showingDatePicker = false
    @State private var formattedDate = ""
    @State private var openPhoto = false
    @State private var image: UIImage?
    @State private var imageUrl: URL? = nil
    @State private var imageData: Data? = nil
    @StateObject var vm : DiaryViewModel
    var body: some View {
        NavigationView{
            ScrollView{
                ZStack{
                    VStack(alignment:.leading,spacing: 5){
                        if openPhoto == false{
                            Button(action: {
                                self.openPhoto = true
                            }, label: {
                                ZStack{
                                    if openPhoto == false{
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.gray, lineWidth: 1.5)
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 200)
                                            .background(.white)
                                            .padding(.vertical,5)
                                            .overlay {
                                                Image("camera")
                                            }
                                    }
                                    
                                    Image(uiImage: image ?? .init())
                                        .resizable()
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 200)
                                        .cornerRadius(10)
                                        .padding(.vertical,5)
                                        .onAppear{
                                            print(image)
                                        }
                                }
                            })
                        }
                        Text("제목")
                            .font(.system(size: 20))
                            .bold()
                        
                        LineTextField(text: $title, TextFieldWidth: .infinity)
                            .overlay(alignment: .topLeading) {
                                Text("제목")
                                    .font(.system(size: 14))
                                    .foregroundStyle(title.isEmpty ? .gray : .clear)
                            }
                            .padding(.bottom, 15)
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
                                    LineTextField(text: $systolicPressure, TextFieldWidth: 30)
                                    Text("/")
                                        .font(.system(size: 16))
                                    LineTextField(text: $diastolicPressure, TextFieldWidth: 30)
                                        .padding(.trailing,30)
                                    
                                    Text("다음 진찰일:")
                                        .font(.system(size: 16))
                                    Text(formattedDate)
                                        .font(.system(size: 13))
                                        .foregroundStyle(.black)
                                    Button(action: {
                                        self.showingDatePicker.toggle()
                                        selectedDateTitle = true
                                    }) {
                                        Image("calendar")
                                            .resizable()
                                            .frame(width: 18, height: 20)
                                    }
                                }
                                .padding(.bottom,15)
                                
                                Text("태아소견")
                                    .font(.system(size: 20))
                                    .bold()
                                
                                LineTextField(text: $Opinion, TextFieldWidth: .infinity)
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
                                
                                Text("본문")
                                    .font(.system(size: 20))
                                    .bold()
                                ScrollView {
                                    TextEditor(text: $Content)
                                        .frame(maxWidth:.infinity,minHeight: 55, maxHeight: .infinity)
                                        .padding(.horizontal, -8)
                                        .padding(.vertical, -10)
                                        .font(.system(size: 14))
                                        .focused($isTextFieldFocused)
                                        .onAppear {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                self.isTextFieldFocused = true
                                            }
                                        }
                                        .overlay(alignment: .topLeading) {
                                            Text("오늘은 어떤일이 있으셨나요?")
                                                .font(.system(size: 14))
                                                .foregroundStyle(Content.isEmpty ? .gray : .clear)
                                        }
                                        .overlay(
                                            GeometryReader { geometry in
                                                Path { path in
                                                    let width = geometry.size.width
                                                    let height = geometry.size.height
                                                    path.move(to: CGPoint(x: 0, y: height))
                                                    path.addLine(to: CGPoint(x: width, y: height))
                                                }
                                                .stroke(Color.primary, lineWidth: 0.5)
                                            }
                                                .frame(height: 1), alignment: .bottom
                                        )
                                        .padding(.bottom,15)
                                }
                                Text("오눌 기분은?")
                                    .font(.system(size: 20))
                                    .bold()
                                    .padding(.bottom,10)
                                
                                HStack(spacing: 30) {
                                    ForEach(Emotion.allCases, id: \.self) { emotion in
                                        IconButtons(emotion: emotion, isSelected: selectedEmotion == emotion) { selected in
                                            selectedEmotion = selected
                                        }
                                    }
                                }
                                .padding(.bottom, 15)
                                
                                Divider()
                                HStack(spacing:10){
                                    Image("private")
                                        .resizable()
                                        .frame(width: 25,height: 25)
                                    Toggle(isOn: $privateToggle, label: {
                                        Text("비공개 : 당신외엔 볼 수 없어요."
                                        ).foregroundStyle(Color.PrimaryLight)
                                            .font(.system(size: 14))
                                    }) .toggleStyle(SwitchToggleStyle(tint: Color.PrimaryLight))
                                }
                                Divider()
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
            .sheet(isPresented: $openPhoto,onDismiss: {
                Task{
                    await vm.upload(image: self.image ?? .init())
                }
            }) {
//                ImagePicker(image: self.$image)
//                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image, imageUrl: $imageUrl, imageData: $imageData)
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
                    Task {
                        let diaryRequest = DiaryRequest(
                            title: title,
                            content: Content,
                            pregnancyWeeks: Int(weeks) ?? 0,
                            weight: Int(weight) ?? 0,
                            systolicPressure: Int(systolicPressure) ?? 0,
                            diastolicPressure: Int(diastolicPressure) ?? 0,
                            nextAppointment: formattedDate,
                            emoji: selectedEmotion?.label ?? "",
                            fetusComment: Opinion,
                            isPublic: privateToggle ? false : true,
                            url: vm.imageUrl != nil ? [vm.imageUrl] : [nil]
//                            url: imageData != nil ? [URL(image)]: [nil]
//                            url: imageData != nil ? [imageData.base64EncodedString()]: [nil]
//                            url: imageUrl != nil ? [imageUrl] : [nil]
//                            url: imageUrl != nil ? [imageUrl!.absoluteURL] : [nil]
                        )
                        await vm.diary(content: diaryRequest)
                        if vm.success {
                            print("imageUrl : \(String(describing: imageData))")
                            dismiss()
                        }
                    }
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(complete ? Color.gray : Color.PrimaryLight, lineWidth: 1)
                            .frame(width: 41,height: 25)
                            .foregroundColor(.white)
                        
                        Text("저장")
                            .foregroundStyle(complete ? Color.gray : Color.PrimaryLight)
                            .font(.system(size: 11))
                    }
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
