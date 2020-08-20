//
//  ContentView.swift
//  Range Slider
//
//  Created by Omar Alejandro Robles Altamirano on 20/08/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View{
    
    @State var width: CGFloat = 0
    @State var width1: CGFloat = 15
    var totalWidth = UIScreen.main.bounds.width - 60
    
    var body: some View{
        
        VStack{
            
            Text("Value")
                .font(.title)
                .fontWeight(.bold)
            
            Text("\(self.getValue(val: self.width/self.totalWidth)) - \(self.getValue(val: self.width1/totalWidth))")
                .fontWeight(.bold)
                .padding(.top)
                
            
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(Color.black.opacity(0.20))
                    .frame(height: 6)
                
                Rectangle()
                    .fill(Color.black)
                    .frame(width: self.width1-self.width, height: 6)
                    .offset(x:self.width+18)
                
                HStack(spacing: 0.0){
                    Circle()
                        .fill(Color.black)
                        .frame(width: 18, height: 18)
                        .offset(x: self.width)
                        .gesture(
                            DragGesture()
                                .onChanged({ (value) in
                                    
                                    if value.location.x >= 0 && value.location.x <= self.width1{
                                        self.width = value.location.x
                                    }
                                })
                        )
                    Circle()
                        .fill(Color.black)
                        .frame(width: 18, height: 18)
                        .offset(x: self.width1)
                        .gesture(
                            DragGesture()
                                .onChanged({ (value) in
                                    
                                    if value.location.x <= self.totalWidth  && value.location.x >= self.width{
                                        self.width1 = value.location.x
                                    }
                                })
                        )
                }
            }
        }
        .padding()
    }
    
    func getValue(val: CGFloat) -> String{
        return String(format: "%.2f", val )
    }
}
