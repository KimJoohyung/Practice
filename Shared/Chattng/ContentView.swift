//
//  ContentView.swift
//  Shared
//
//  Created by 김주형 on 2022/03/29.
//

import SwiftUI

struct ContentView: View {
    
//    let chats = Chat.sampleChat
    @StateObject var viewModel = ChatsViewModel()
    
    @State private var query = ""
    
    var body: some View {
//        NavigationView{
            if #available(iOS 15.0, *) {
                List{
                    ForEach(viewModel.getSortedFilteredChats(query: query)){ chat in
                        ZStack{
                            ChatRow(chat: chat)
                            NavigationLink(destination: {
                                ChatView(chat: chat)
                                    .environmentObject(viewModel)
                            }){
//                                ChatRow(chat: chat)
                                EmptyView()
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width:0)
                            .opacity(0)
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button {
                                viewModel.markAsUnread(!chat.hasUnreadMessage, chat: chat)
                            }label: {
                                if chat.hasUnreadMessage{
                                    Label("READ",systemImage: "text.bubble")
                                }else{
                                    Label("UnRead",systemImage: "circle.fill")
                                }
                            }
                            .tint(.blue)
                        }
                        
                    }
                }
                .listStyle(PlainListStyle())
                .searchable(text: $query)
                .navigationTitle("CHATS")
                .navigationBarItems(trailing: Button(action: {}){
                    Image(systemName: "square.and.pencil")
                })
            } else {
                List{
                    ForEach(viewModel.chats){ chat in
                        ChatRow(chat : chat)
                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle("CHATS")
                .navigationBarItems(trailing: Button(action: {}){
                    Image(systemName: "square.and.pencil")
                })
            }
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
            
    }
}
