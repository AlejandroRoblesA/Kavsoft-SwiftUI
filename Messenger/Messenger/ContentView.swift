//
//  ContentView.swift
//  Messenger
//
//  Created by Omar Alejandro Robles Altamirano on 07/07/20.
//  Copyright © 2020 Omar Alejandro Robles Altamirano. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State var name = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.orange
                VStack{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding(.top, 12)
                    TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    
                    if self.name != ""{
                        NavigationLink(destination: MessagePage(name: self.name)){
                            HStack{
                                Text("Join")
                                Image(systemName: "arrow.right.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                            }
                        }
                        .frame(width: 100, height: 54)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding(.bottom, 15 )
                    }
                }
                .background(Color.white)
                .cornerRadius(20)
                .padding()
            }
            .edgesIgnoringSafeArea(.all)
        }
        .animation(.default)
    }
}

struct MessagePage: View{
    
    var name = ""
    
    @ObservedObject var message = Observer()
    @State var typedMessage = ""
    
    var body: some View{
        
        
        VStack{
            List(message.messages){ i in
                
                if i.name == self.name{
                    MessageRow(message: i.message, myMessage: true, user: i.name)
                }
                else{
                    MessageRow(message: i.message, myMessage: false, user: i.name)
                }
                
                
            }
            .navigationBarTitle("Chat", displayMode: .inline)
            
            HStack{
                TextField("Write you message", text: $typedMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    self.message.addMessage(text: self.typedMessage, user: self.name)
                    self.typedMessage = ""
                }){
                    Text("Send")
                }
            }
        .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class Observer: ObservableObject{
    
    @Published var messages =  [DataType]()
    
    init (){
        let db = Firestore.firestore()
        db.collection("Messages").addSnapshotListener{ snap, error in
            if error != nil{
                print((error?.localizedDescription)!)
                return
            }

            for i in snap!.documentChanges{
                if i.type == .added{
                    let name = i.document.get("name") as! String
                    let message = i.document.get("message") as! String
                    let id = i.document.documentID
                    
                    self.messages.append(DataType(id: id, name: name, message: message))
                }
            }
            
        }
    }
    
    func addMessage(text: String, user: String){
        let db = Firestore.firestore()
        db.collection("Messages").addDocument(data: ["message": text, "name": user]) { (error) in
            if error != nil{
                print((error?.localizedDescription)!)
                return
            }
        }
    }
}

struct DataType: Identifiable{
    var id: String
    var name: String
    var message: String
}

struct MessageRow: View{
    
    var message = ""
    var myMessage = false
    var user = ""
    
    var body: some View{
        HStack{
            if myMessage{
                Spacer()
                Text(message)
                    .padding(8)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(6)
            }
            else{
                HStack{
                    Text("\(user):")
                    .foregroundColor(.white)
                        .padding(.leading, 6)
                    Text(message)
                        .padding(8)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(6)
                    
                }
                .background(Color.blue)
                .cornerRadius(6)
                Spacer()
            }
        }
    }
}
