//
//  ContentView.swift
//  Instagram
//
//  Created by Omar Alejandro Robles Altamirano on 08/07/20.
//  Copyright © 2020 Omar Alejandro Robles Altamirano. All rights reserved.
//

import SwiftUI
import Firebase

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
            }.tabItem{
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
    var body: some View{
        
        ScrollView(.vertical, showsIndicators: false){
            
            VStack{
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(0..<5){ _ in
                            StatusCard(imageName: "maiden")
                                .padding(.horizontal, 10)
                        }
                    }
                }
                ForEach(0..<8){ _ in
                    
                    PostCard(user: "", image: "", id: "")
                    
                }
            }
            
        }
    }
}


struct StatusCard: View {
    
    var imageName = ""
    
    var body: some View{
    
        Image(imageName)
            .resizable()
            .frame(width: 60, height: 60)
            .clipShape(Circle())
    }
}

struct PostCard: View{
    
    var user = ""
    var image = ""
    var id = ""
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Image("maiden")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                Text("User")
                Spacer()
                Button(action:{
                    
                }){
                    Image(systemName: SFSimbolsImages().menu)
                        .resizable()
                        .frame(width: 15, height: 15)
                }
                .foregroundColor(Color("darkAndWhite"))
            }
            
            Image("maiden")
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
            
            Text("2 Likes")
                .padding(.top, 8)
            Text("View all 3 Comments")
        }
    .padding(8)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
