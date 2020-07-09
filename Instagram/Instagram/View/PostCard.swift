//
//  PostCard.swift
//  Instagram
//
//  Created by Omar Alejandro Robles Altamirano on 09/07/20.
//  Copyright © 2020 Omar Alejandro Robles Altamirano. All rights reserved.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

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
                    let db = Firestore.firestore()
                    let like = Int.init(self.likes)!
                    db.collection("posts").document(self.id).updateData(["likes" : "\(like + 1)"]){ error in
                        if (error != nil){
                            print(error!)
                            return
                        }
                        print("Updated")
                    }
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
