//
//  NoticeBoardDetailView.swift
//  babya
//
//  Created by hyk on 6/4/24.
//

import SwiftUI

struct NoticeBoardDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.refresh) private var refresh
    @FocusState private var isFocused: Bool
    @StateObject var vm: NoticeBoardDetailViewModel
    let postId: Int
    @State var inputText : String = ""
    @State var nowPage : Int = 1
    @State var nowCommentPage : Int = 1
    @State var subResponse = [SubCommentResponse]()
    @State var isClick : Bool = false
    @State var postSubComment : Bool = false
    @State var parentCommentId : Int = 0
    @State var subCommentList = [SubCommentResponse]()
    @State var loding : Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                HStack(spacing: 10) {
                    Circle()
                        .frame(width: 45, height: 45)
                        .overlay {
                            Image("baseProfile")
                                .resizable()
                                .scaledToFit()
                        }
                    
                    VStack(spacing: 3) {
                        HStack {
                            Text(vm.model.data.nickname)
                                .font(.system(size: 16, weight: .bold))
                            Button {
                                // Button action here
                            } label: {
                                Image(systemName: "star")
                                    .font(.system(size: 15))
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                        }
                        
                        HStack {
                            Image(systemName: "eye.fill")
                                .foregroundColor(.gray)
                            
                            Text("\(vm.model.data.view)")
                            
                            Image(systemName: "bubble")
                                .foregroundColor(.gray)
                            
                            Text("\(vm.model.data.commentCnt)")
                            
                            Spacer()
                        }
                        .font(.system(size: 15))
                    }
                }
                .padding(.horizontal, 20)
                
                if let fileURLString = vm.model.data.files?.first?.url, let fileURL = URL(string: fileURLString) {
                        AsyncImage(url: fileURL) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 240)
                    }
                
                HStack {
                    Text(vm.model.data.content)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                HStack {
                    Spacer()
                    
                    Text(vm.model.data.createdAt.prefix(10))
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .padding(.top)
                        .padding(.horizontal, 20)
                }
                
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: 1)
                    .foregroundColor(.gray)
                    .padding(.vertical, 10)

                ForEach((0..<vm.commentCount), id: \.self) { count in
                    CommentCeil(Comment: vm.comment[count], postSubComment: $postSubComment, parentCommentId: $parentCommentId)
                        .padding(.vertical,5)
                        .onAppear{
                            if count == 9 {
                                nowPage += 1
                                print("page :: \(nowPage)")
                            }
                            print("count : \(count)")
                            
                        }
                    if vm.comment[count].subCommentCnt != 0 && loding {
                        let cnt = (count != 0) ? subCommentList.count : vm.comment[count].subCommentCnt
                        let aa = (count != 0) && (vm.comment[count - 1].subCommentCnt != 0) ? (vm.comment[count - 1].subCommentCnt) : 0
                        ForEach(aa..<min(cnt, subCommentList.count) , id: \.self) { index in
                            SubCommentCeil(ProfileImage: subCommentList[index].profileImg ?? "baseProfile",
                                           UserName: subCommentList[index].nickname,
                                           Days: subCommentList[index].createdAt,
                                           Content: subCommentList[index].content)
                            .padding(.leading, 10)
                            .onAppear {
                                if index % 10 == 9 {
                                    nowCommentPage += 1
                                    print("page :: \(nowCommentPage)")
                                }
                            }
                        }
                    }
                    Divider()
                }
            }
            
            VStack(spacing: 0) {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)

                HStack(spacing: 1){
                    Image("baseProfile")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(minWidth: 25,maxHeight: 25)
                    
                    TextField("댓글달기", text: $inputText)
                        .textFieldStyle(TextfieldStyle(isClick: $isClick))
                    
                }
      
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text(vm.model.data.title)
                    .font(.system(size: 20, weight: .bold))
            }
        }
        .navigationBarBackButtonHidden()
        .refreshable {
            vm.getPostDetail(postId: postId)
            Task{
                nowPage = 1
                await vm.getCommentPost(pageRequest: PageRequest(page: nowPage, size: 50), id: postId)
                subCommentList = vm.subComment
                loding = true
            }
        }
        .onAppear{
            vm.getPostDetail(postId: postId)
            Task{
                nowPage = 1
                await vm.getCommentPost(pageRequest: PageRequest(page: nowPage, size: 50), id: postId)
                subCommentList = vm.subComment
                loding = true
            }
        }
        .onChange(of: isClick){
            if isClick{
                if postSubComment{
                    vm.subCommentCount = 0
                    vm.subComment = []
                }else{
                    vm.commentCount = 0
                }
                Task{
                    loding = false
                    await vm.postComment(comment: inputText, postId: postId, parentCommentId: postSubComment ? parentCommentId : 0)
                    inputText = ""
                    await vm.getCommentPost(pageRequest: PageRequest(page: nowPage, size: 50), id: postId)
                    if postSubComment{
                        subCommentList = vm.subComment
                    }
                    postSubComment = false
                    loding = true
                }
            }
        }
    }
}
#Preview {
    NavigationView {
        NoticeBoardDetailView(vm: NoticeBoardDetailViewModel(noticeBoardService: RemoteNoticeBoardService()), postId: 1)
    }
}
