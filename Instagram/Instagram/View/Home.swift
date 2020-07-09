//
//  Home.swift
//  Instagram
//
//  Created by Omar Alejandro Robles Altamirano on 09/07/20.
//  Copyright © 2020 Omar Alejandro Robles Altamirano. All rights reserved.
//

import SwiftUI

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

