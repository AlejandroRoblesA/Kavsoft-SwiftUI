//
//  Observers.swift
//  Instagram
//
//  Created by Omar Alejandro Robles Altamirano on 09/07/20.
//  Copyright © 2020 Omar Alejandro Robles Altamirano. All rights reserved.
//

import SwiftUI
import Firebase

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
                    
                    for j in 0..<self.posts.count {
                        if self.posts[j].id == id {
                            self.posts.remove(at: j)
                            return
                        }
                    }
                }
                
                if i.type == .modified{
                    let id = i.document.documentID
                    let likes = i.document.get("likes") as! String
                    
                    for j in 0..<self.posts.count {
                        if self.posts[j].id == id {
                            self.posts[j].likes = likes
                            return
                        }
                    }
                }
            }
        }
    }
}
