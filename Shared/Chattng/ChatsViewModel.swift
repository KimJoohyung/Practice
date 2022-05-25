//
//  ChatsViewModel.swift
//  Practices
//
//  Created by 김주형 on 2022/04/06.
//

import Foundation

class ChatsViewModel:ObservableObject{
    @Published var chats = Chat.sampleChat
    
    
    func getSortedFilteredChats(query:String)->[Chat]{
        //시간순으로 소팅 먼저 한번하고.
        let sortedChats = chats.sorted {
            guard let date1 = $0.messages.last?.date else {return false}
            guard let date2 = $1.messages.last?.date else {return false}

            return date1 > date2
        }
        
        //검색어가 있는경우
        if query == ""{
            return sortedChats
        }
        
        //없는경우
        return sortedChats.filter{$0.person.name.lowercased().contains(query.lowercased())}
    }
    
    func getSectionMessages(for chat:Chat)->[[Message]]{
        var res = [[Message]]()
        var tmp = [Message]()
        
        for message in chat.messages{
            if let firstmessage = tmp.first{
                let daysBetween = firstmessage.date!.daysBetween(date: message.date ?? Date())
                    if daysBetween >= 1{
                        res.append(tmp)
                        tmp.removeAll()
                        tmp.append(message)
                    }else{
                        tmp.append(message)
                    }
                
            }else{
                tmp.append(message)
            }
        }
        res.append(tmp)
        return res
    }
    
    func markAsUnread(_ newValue:Bool,chat:Chat){
        if let index = chats.firstIndex(where: {$0.id == chat.id}){
            chats[index].hasUnreadMessage = newValue
        }
    }
    
    func sendMessage(_ text:String,in chat:Chat) -> Message?{
        if let index = chats.firstIndex(where: {$0.id == chat.id}){
            let message = Message(text,type: .Sent)
            chats[index].messages.append(message)
            return message
        }
        return nil
    }
}
