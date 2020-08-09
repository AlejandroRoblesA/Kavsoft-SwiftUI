//
//  ContentView.swift
//  Ratings
//
//  Created by Omar Alejandro Robles Altamirano on 08/08/20.
//  Copyright © 2020 Omar Alejandro Robles Altamirano. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var selected = -1
    
    var body: some View {
        VStack{
            if selected != -1 {
                Text("\(selected+1)")
                    .padding(.bottom, 10)
                    .foregroundColor(.purple)
                    .font(.largeTitle)
            }
            
            Stars(selected: $selected)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Stars: View {
    
    @Binding var selected: Int
    
    var body: some View{
        HStack(spacing: 10){
            ForEach(0..<5){i in
                Image(systemName: self.selected >= i ? "star.fill" : "star")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(self.selected >= i ? .yellow : .gray)
                .onTapGesture {
                    self.selected = i
                }
            }
        }
    }
}
