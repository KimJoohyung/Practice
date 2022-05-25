//
//  ChatView.swift
//  Practices
//
//  Created by 김주형 on 2022/04/07.
//

import SwiftUI

struct ChatView: View {
    
    @EnvironmentObject var viewModel : ChatsViewModel
    
    let chat:Chat
    
    @State private var text = ""
    @FocusState private var isFocused 
    
    @State private var messageIDToScroll : UUID?
    
    var body: some View {
        
        VStack{
            GeometryReader{ reader in
                ScrollView{
                    ScrollViewReader{scrollReader in
                        getMessagesView(viewWidth: reader.size.width)
                        .padding(.horizontal)
                        .onChange(of: messageIDToScroll) { _ in
                            if let messageID = messageIDToScroll{
                                scrollTo(messageID: messageID, shouldAnimate: true, scrollReader: scrollReader)
                            }
                        }
                        .onAppear{
                            if let messageID = chat.messages.last?.id{
                                scrollTo(messageID: messageID, anchor: .bottom, shouldAnimate: false, scrollReader: scrollReader)
                            }
                        }
                    }
                    
                }
            }
//            .background(Color.yellow)
            .padding(.bottom,2)
            toolbarView()
            
            
        }
//        .edgesIgnoringSafeArea(.bottom)
//        .padding(.bottom,1)
        .padding(.top,1)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                navBarLeadingBtn
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                navBarTrailingBtn
            }
        }
        .onAppear{
            viewModel.markAsUnread(false, chat: chat)
        }
    }
    
    var navBarLeadingBtn : some View{
        Button(action: {}){
            HStack{
                Image(chat.person.imgString)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                Text(chat.person.name).bold()
            }
            .foregroundColor(.black)
        }
    }
    
    var navBarTrailingBtn : some View{
        HStack{
            Button(action: {}) {
                Image(systemName: "video")
            }
            Button(action: {}) {
                Image(systemName: "line.3.horizontal")
            }
        }
    }
    
    func scrollTo(messageID:UUID,anchor:UnitPoint? = nil,shouldAnimate:Bool,scrollReader:ScrollViewProxy){
        DispatchQueue.main.async {
            withAnimation(shouldAnimate ? Animation.easeIn : nil){
                scrollReader.scrollTo(messageID, anchor: anchor)
            }
        }
    }
    
    
    func toolbarView() -> some View{
        
            VStack{
                let height : CGFloat = 37
                HStack{
                    if #available(iOS 15.0, *) {
                        TextField("입력하세요",text:$text)
                            .padding(.horizontal,10)
                            .frame(height:height)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 13))
                            .focused($isFocused)
                    } else {
                        TextField("입력하세요",text:$text)
                            .padding(.horizontal,10)
                            .frame(height:height)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 13))
                        // Fallback on earlier versions
                    }
                    
                    Button(action: sendMessage){
                     Image(systemName: "paperplane.fill")
                            .foregroundColor(.white)
                            .frame(width: height, height: height)
                            .background(
                                Circle()
                                    .foregroundColor(text.isEmpty ? .gray : .blue)
                            )
                    }
                    .disabled(text.isEmpty)
                }
                .frame(height:height)
            }
            .padding(.vertical)
            .padding(.horizontal)
            .background(Color.gray.opacity(0.1))
            
            
        
    }
        
    let colums = [GridItem(.flexible(minimum: 10))]
    
    func getMessagesView(viewWidth:CGFloat)-> some View{
        LazyVGrid(columns: colums,spacing: 0,pinnedViews: [.sectionHeaders]) {
            let sectionMessages = viewModel.getSectionMessages(for: chat)
            ForEach(sectionMessages.indices,id:\.self){sectionIndex in
                let messages = sectionMessages[sectionIndex]
                Section(header: sectionHeader(firstMessage: messages.first!)) {
                    ForEach(messages){message in
                        let isReceived = message.type == .Received
                        HStack{
                            ZStack{
                                Text(message.text)
                                    .padding(.horizontal)
                                    .padding(.vertical,12)
                                    .background(isReceived ? Color.black.opacity(0.2) : Color.green.opacity(0.9))
                                    .background(Color.blue)
                                    .clipShape(RoundedRectangle(cornerRadius: 13))
                            }
                            .frame(width: viewWidth * 0.7, alignment: isReceived ? .leading : .trailing)
                            .padding(.vertical)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: isReceived ? .leading : .trailing)
                        .id(message.id)
                    }
                }
            }
        
            
        }
    }
    
    func sectionHeader(firstMessage message: Message) -> some View{
        ZStack{
            
                Text(message.date!.descriptiveString(dateStyle: .medium))
                    .font(.system(size: 14, weight: .regular))
                    .frame(width:120)
                    .padding(.vertical,5)
                    .background(Capsule().foregroundColor(.blue))
                    .foregroundColor(.white)
            
//            else{
//                EmptyView()
//                print("EMPTYVIEW")
//            }
        }
        .padding(.vertical,5)
        .frame(maxWidth: .infinity)
    }
    
    func sendMessage(){
        if let message = viewModel.sendMessage(text, in: chat){
            text = ""
            messageIDToScroll = message.id
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ChatView(chat:Chat.sampleChat[2])
                .environmentObject(ChatsViewModel())
        }
        
    }
}
