//
//  ContentView.swift
//  Instagram
//
//  Created by Omar Alejandro Robles Altamirano on 08/07/20.
//  Copyright © 2020 Omar Alejandro Robles Altamirano. All rights reserved.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView{
            NavigationView{
                Home()
                    .navigationBarTitle("Instagram")
                    .navigationBarItems(
                        leading:
                            Button(action:{
                                
                            }){
                                Image(systemName: SFSimbolsImages().camera)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                            }
                            .foregroundColor(Color("darkAndWhite"))
                        , trailing:
                            HStack{
                                Button(action:{
                                    
                                }){
                                    Image(systemName: SFSimbolsImages().tv)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                }
                                .foregroundColor(Color("darkAndWhite"))
                                
                                Button(action: {
                                    
                                }){
                                    Image(systemName: SFSimbolsImages().send)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                }
                                .foregroundColor(Color("darkAndWhite"))
                            }
                    )
            }
            .tabItem{
                Image(systemName: SFSimbolsImages().home)
            }
            
            Text("Find")
                .tabItem{
                    Image(systemName: SFSimbolsImages().magnifyingglass)
                        .frame(width: 40, height: 40)
            }
            
            Text("Upload")
                .tabItem{
                    Image(systemName: SFSimbolsImages().plus)
                        .frame(width: 40, height: 40)
            }
            
            Text("Likes")
                .tabItem{
                    Image(systemName: SFSimbolsImages().heart)
                        .frame(width: 40, height: 40)
            }
            
            Text("Profile")
                .tabItem{
                    Image(systemName: SFSimbolsImages().user)
                        .frame(width: 40, height: 40)
            }
        }
    }
}

struct Home: View{
    
    @ObservedObject var observer = Observer()
    @ObservedObject var postsObsever = PostsObserver()
    @State var show = false
    @State var user = ""
    @State var url  = ""
    
    var body: some View{
        
        ScrollView(.vertical, showsIndicators: false){
            
            VStack{
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(observer.status){ snap in
                            StatusCard(imageName: snap.image, user: snap.name, show: self.$show, user1: self.$user, url: self.$url)
                                .padding(.horizontal, 10)
                        }
                    }
                    .animation(.spring())
                }
                
                if postsObsever.posts.isEmpty{
                    Text("No Posts")
                        .fontWeight(.heavy)
                }
                else{
                    ForEach(postsObsever.posts){ snap in
                        
                        PostCard(user: snap.name, image: snap.image, id: snap.id,  likes: snap.likes, comments: snap.comments)
                    }
                }
            }
        }
        .sheet(isPresented: $show){
            
            StatusView(url: self.url, name: self.user)
        }
    }
}

struct StatusCard: View {
    
    var imageName = ""
    var user = ""
    
    @Binding var show: Bool
    @Binding var user1: String
    @Binding var url: String
    
    var body: some View{
         
        VStack{
            AnimatedImage(url: URL(string: imageName))
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .onTapGesture {
                    self.user1 = self.user
                    self.url = self.imageName
                    self.show.toggle()
                }
            
            Text(user).fontWeight(.light)
        }
    }
}

struct PostCard: View{
    
    var user = ""
    var image = ""
    var id = ""
    var likes = ""
    var comments = ""
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                AnimatedImage(url: URL(string: image))
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                Text(user)
                Spacer()
                Button(action:{
                    
                }){
                    Image(systemName: SFSimbolsImages().menu)
                        .resizable()
                        .frame(width: 15, height: 15)
                }
                .foregroundColor(Color("darkAndWhite"))
            }
            
            AnimatedImage(url: URL(string: image))
                .resizable()
                .frame(height: 350)
            
            HStack{
                Button(action: {
                    
                }){
                    Image(systemName: SFSimbolsImages().captionsBubble)
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .foregroundColor(Color("darkAndWhite"))
                
                Button(action: {
                    
                }){
                    Image(systemName: SFSimbolsImages().heart)
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .foregroundColor(Color("darkAndWhite"))
                
                Spacer()
                
                Button(action: {
                    
                }){
                    Image(systemName: SFSimbolsImages().save)
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .foregroundColor(Color("darkAndWhite"))
            }
            .padding(.top, 8)
            
            Text("\(likes) Likes")
                .padding(.top, 8)
            Text("View \(comments) Comments")
        }
        .padding(8)
    }
}

class Observer: ObservableObject{
    
    @Published var status = [Datatype]()
    
    init (){
        let db = Firestore.firestore()
        db.collection("status").addSnapshotListener{ snap, error in
            
            if (error != nil){
                print(error!.localizedDescription)
                return
            }
            
            for i in snap!.documentChanges{
                if (i.type == .added){
                    let id = i.document.documentID
                    let name = i.document.get("name") as! String
                    let image = i.document.get("image") as! String
                    
                    self.status.append(Datatype(id: id, name: name, image: image))
                }
                
                if (i.type == .removed){
                    let id = i.document.documentID
                    
                    for j in 0..<self.status.count{
                        if self.status[j].id == id{
                            self.status.remove(at: j)
                            return
                        }
                    }
                }
            }
        }
    }
}

struct Datatype: Identifiable{
    var id: String
    var name: String
    var image: String
}

class PostsObserver: ObservableObject{
    
    @Published var posts = [PostsDatatype]()
    
    init (){
        let db = Firestore.firestore()
        db.collection("posts").addSnapshotListener{ snap, error in
            
            if (error != nil){
                print(error!.localizedDescription)
                return
            }
            
            for i in snap!.documentChanges{
                if (i.type == .added){
                    let id = i.document.documentID
                    let name = i.document.get("name") as! String
                    let image = i.document.get("image") as! String
                    let comment = i.document.get("comments") as! String
                    let likes = i.document.get("likes") as! String
                    
                    self.posts.append(PostsDatatype(id: id, name: name, image: image, comments: comment, likes: likes))
                }
                
                if (i.type == .removed){
                    let id = i.document.documentID
                    
                    for j in 0..<self.posts.count{
                        if self.posts[j].id == id{
                            self.posts.remove(at: j)
                            return
                        }
                    }
                }
            }
        }
    }
}

struct PostsDatatype: Identifiable{
    var id:       String
    var name:     String
    var image:    String
    var comments: String
    var likes:    String
}

struct StatusView: View{
    
    var url = ""
    var name = ""
    
    var body: some View{
        
        ZStack{
            AnimatedImage(url: URL(string: url))
            .resizable()
            .edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack{
                    Text(name)
                    .foregroundColor(Color("darkAndWhite"))
                        .font(.headline)
                        .fontWeight(.heavy)
                        .padding()
                        .background(Color.white)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
