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
         Text("Home")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
