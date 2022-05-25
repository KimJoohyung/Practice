//
//  ChatModel.swift


import Foundation

struct Chat:Identifiable{
    var id: UUID{person.id}
    let person:Person
    var messages : [Message]
    var hasUnreadMessage = false
}

struct Person:Identifiable{
    let id = UUID()
    let name : String
    let imgString : String
}

struct Message :Identifiable{
     
    enum messageType{
        case Sent, Received
    }
    
    let id = UUID()
    let date : Date?
    let text : String
    let type : messageType
    
    init(_  text: String, type: Message.messageType, date: Date? = Date()) {
       self.date = date ?? Date()
       self.text = text
       self.type = type
   }
}


extension Chat{
    static let sampleChat = [
        Chat(person: Person(name: "Hakim", imgString: "img1"), messages: [
            Message("Hey Hakim", type: .Sent, date: Date(timeIntervalSinceNow: -86400*20)),
            Message("Hi there", type: .Sent, date: Date(timeIntervalSinceNow: -86400*19)),
            Message("This is Andrew from the Banuba team", type: .Sent, date: Date(timeIntervalSinceNow: -86400*17)),
            Message("hello good to see you again", type: .Received, date: Date(timeIntervalSinceNow: -86400*15)),
            Message("we can arrange a call if possible", type: .Sent, date: Date(timeIntervalSinceNow: -86400*15)),
            Message("hmm. it's sorry to give you and badNews. our boss, is not safisfy of the efficency to apply the banuda applycation. -because of the cost is too big….you know.. so we have to change the start point the application service way. its very sorry to say . if we have another change. i hope work with the banuda service.", type: .Received, date: Date(timeIntervalSinceNow: -86400*15)),
            Message("Hey Hakim", type: .Received, date: Date(timeIntervalSinceNow: -86400*4)),
        ], hasUnreadMessage: true),
        Chat(person: Person(name: "Andrew", imgString: "img2"), messages: [
            Message("i need your help but i can explain on this chatting. so. i gave you email. please reply me when you check the email", type: .Sent, date: Date(timeIntervalSinceNow: -86400*3)),
            Message("thank you.", type: .Sent, date: Date(timeIntervalSinceNow: -86400*3)),
            Message("my version is.", type: .Sent, date: Date(timeIntervalSinceNow: -86400*3)),
            Message(".2.1 (13C100)", type: .Received, date: Date(timeIntervalSinceNow: -86400*3)),
            Message("Bir Sur(11.4)", type: .Sent, date: Date(timeIntervalSinceNow: -86400*6)),
            Message("Andrew if you need technical assistance, it's better to pass this to our support team", type: .Received, date: Date(timeIntervalSinceNow: -86400*2)),
            Message("Andrew I'm not a developer myself", type: .Received, date: Date()),
        ], hasUnreadMessage: true),
        Chat(person: Person(name: "josh", imgString: "img3"), messages: [
            Message("Andrew https://docs.banuba.com/face-ar-sdk/support", type: .Sent, date: Date(timeIntervalSinceNow: -86400*8)),
            Message("Andrew use this link", type: .Sent, date: Date(timeIntervalSinceNow: -86400*7)),
            Message("Andrew and I will push them to reply asap", type: .Sent, date: Date(timeIntervalSinceNow: -86400*6)),
            Message("Andrew because for me it's hard to see what's the problem based on your log", type: .Received, date: Date(timeIntervalSinceNow: -86400*5)),
            Message("Andrew they usually reply within a cou", type: .Sent, date: Date(timeIntervalSinceNow: -86400*4)),
            Message("Andrew couple of hours", type: .Received, date: Date(timeIntervalSinceNow: -86400*3)),
            Message("Andrew hi there", type: .Sent, date: Date(timeIntervalSinceNow: -86400*3)),
            Message("Andrew how are you?", type: .Sent, date: Date(timeIntervalSinceNow: -86400*3)),
            Message("Andrew and how's your testing going?", type: .Received, date: Date(timeIntervalSinceNow: -86400*3)),
            Message("김주형 hello i am testing and showing to my boss and wait for response i got some news i will send you a message", type: .Sent, date: Date(timeIntervalSinceNow: -86400*2)),
            Message("Andrew thank you for the update", type: .Received, date: Date(timeIntervalSinceNow: -86400*2)),
            Message("Andrew see you there", type: .Received, date: Date(timeIntervalSinceNow: -86400*1)),
            Message("김주형 ok i will thank you 😊", type: .Received, date: Date(timeIntervalSinceNow: -86400*1)),
        ], hasUnreadMessage: true),
        Chat(person: Person(name: "nataly", imgString: "img4"), messages: [
            Message("(null) 표시할 수 없는 메시지입니다.", type: .Sent, date: Date(timeIntervalSinceNow: -86400*3)),
            Message("Andrew hi there", type: .Sent, date: Date(timeIntervalSinceNow: -86400*3)),
            Message("Andrew how are you?", type: .Sent, date: Date(timeIntervalSinceNow: -86400*3)),
            Message("Andrew and how's your testing going?", type: .Received, date: Date(timeIntervalSinceNow: -86400*3)),
            Message("김주형 hello i am testing and showing to my boss and wait for response i got some news i will send you a message", type: .Sent, date: Date(timeIntervalSinceNow: -86400*2)),
            Message("Andrew thank you for the update", type: .Received, date: Date(timeIntervalSinceNow: -86400*2)),
            Message("Andrew see you there", type: .Received, date: Date(timeIntervalSinceNow: -86400*1)),
        ], hasUnreadMessage: false),
        Chat(person: Person(name: "robe", imgString: "img5"), messages: [
            Message("김주형 yep thank you! i will keep in touch ASAP", type: .Sent, date: Date(timeIntervalSinceNow: -86400*3)),
            Message("(null) 표시할 수 없는 메시지입니다.", type: .Sent, date: Date(timeIntervalSinceNow: -86400*3)),
            Message("Andrew hi there", type: .Sent, date: Date(timeIntervalSinceNow: -86400*3)),
            Message("Andrew This is Andrew from the Banuba team", type: .Received, date: Date(timeIntervalSinceNow: -86400*3)),
            Message("김주형 hello good to see you again", type: .Sent, date: Date(timeIntervalSinceNow: -86400*2)),
            Message("Andrew Seems that you trial is close to its end, so i'm following up to check how are you?", type: .Received, date: Date(timeIntervalSinceNow: -86400*2)),
            Message("Andrew and how's your project going?", type: .Received, date: Date(timeIntervalSinceNow: -86400*1)),
        ], hasUnreadMessage: true),
        Chat(person: Person(name: "kris", imgString: "img6"), messages: [
            Message("김주형 hmm.", type: .Sent, date: Date(timeIntervalSinceNow: -86400*6)),
            Message("to give you and badNews.", type: .Sent, date: Date(timeIntervalSinceNow: -86400*6)),
            Message("not safisfy of the efficency to apply the banuda applycation. -because of the cost is too big….you know..", type: .Sent, date: Date(timeIntervalSinceNow: -86400*6)),
            Message("change the start point the application service way.", type: .Received, date: Date(timeIntervalSinceNow: -86400*6)),
            Message("say .", type: .Sent, date: Date(timeIntervalSinceNow: -86400*6)),
            Message("change. ", type: .Received, date: Date(timeIntervalSinceNow: -86400*5)),
            Message("the banuda service.", type: .Received, date: Date(timeIntervalSinceNow: -86400*5)),
        ], hasUnreadMessage: false),
        Chat(person: Person(name: "josh", imgString: "img7"), messages: [
            Message("(null) 표시할 수 없는 메시지입니다.", type: .Sent, date: Date(timeIntervalSinceNow: -86400*10)),
            Message("Andrew Hi there", type: .Sent, date: Date(timeIntervalSinceNow: -86400*20)),
            Message("Andrew Thank you for your reply. Anyway, maybe we can discuss your boss price expectation? If you like our technologies I guess we can agree the special price", type: .Sent, date: Date(timeIntervalSinceNow: -86400*20)),
            Message("김주형 hello.", type: .Received, date: Date(timeIntervalSinceNow: -86400*19)),
            Message("your suggest, i'll disscuss to my boss about this", type: .Sent, date: Date(timeIntervalSinceNow: -86400*18)),
            Message("Andrew we can arrange a call if possible", type: .Received, date: Date(timeIntervalSinceNow: -86400*18)),
            Message("Andrew or you can add him here", type: .Received, date: Date(timeIntervalSinceNow: -86400*18)),
        ], hasUnreadMessage: false),
    ]
}
