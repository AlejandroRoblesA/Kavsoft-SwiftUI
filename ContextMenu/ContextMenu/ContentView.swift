//
//  ContentView.swift
//  ContextMenu
//
//  Created by Omar Alejandro Robles Altamirano on 22/07/20.
//  Copyright © 2020 Omar Alejandro Robles Altamirano. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image("apple")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 300)
        .padding()
            .contextMenu{
                VStack{
                    Button(action:{
                        print("save...")
                    }){
                        HStack{
                            Image(systemName: "folder.fill")
                            Text("Save to gallery")
                        }
                    }
                    
                    Button(action:{
                        print("send..")
                    }){
                        HStack{
                            Image(systemName: "paperplane.fill")
                            Text("Send")
                        }
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
