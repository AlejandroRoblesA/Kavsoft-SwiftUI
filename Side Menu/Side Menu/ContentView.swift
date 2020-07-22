//
//  ContentView.swift
//  Side Menu
//
//  Created by Omar Alejandro Robles Altamirano on 22/07/20.
//  Copyright © 2020 Omar Alejandro Robles Altamirano. All rights reserved.
//

import SwiftUI

struct Images{
    let close = "xmark.circle.fill"
    let menu = "folder.circle.fill"
}

struct ContentView: View {
    
    @State var size = UIScreen.main.bounds.width / 1.6
    
    var body: some View {
        
        ZStack{
            Color.red
            
            NavigationView{
                List(0..<5){ _ in
                     Text("Hello")
                }
                .navigationBarTitle("Home")
                .navigationBarItems(leading:
                    Button(action: {
                        self.size = 0
                    }){
                        Image(systemName: Images().menu)
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    .foregroundColor(Color.black)
                )
            }
            
            HStack{
                Menu(size: $size)
                    .padding(.leading, -size)
                    .offset(x: -size)
                Spacer()
            }
        }
        .animation(.spring())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Menu: View{
    
    @Binding var size: CGFloat
    
    var body: some View{
        VStack{
            
            HStack{
                Spacer()
                Button(action:{
                    self.size = UIScreen.main.bounds.width/1.6
                }){
                    Image(systemName: Images().close)
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(6)
                }
                .background(Color.red)
                .foregroundColor(Color.white)
                .clipShape(Circle())
                
            }
            
            HStack{
                Image(systemName: "house.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding()
                Text("Home").fontWeight(.heavy)
                Spacer()
            }
            HStack{
                Image(systemName: "folder.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding()
                Text("Files ").fontWeight(.heavy)
                Spacer()
            }
            HStack{
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding()
                Text("Send").fontWeight(.heavy)
                Spacer()
            }
            HStack{
                Image(systemName: "pencil")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding()
                Text("Edit").fontWeight(.heavy)
                Spacer()
            }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width/1.6 )
        .background(Color.white)
    }
}
