//
//  StatusView.swift
//  Instagram
//
//  Created by Omar Alejandro Robles Altamirano on 09/07/20.
//  Copyright © 2020 Omar Alejandro Robles Altamirano. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

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

