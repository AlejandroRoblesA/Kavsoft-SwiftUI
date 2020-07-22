//
//  ContentView.swift
//  SwipeUpDown
//
//  Created by Omar Alejandro Robles Altamirano on 22/07/20.
//  Copyright © 2020 Omar Alejandro Robles Altamirano. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var size: CGFloat = UIScreen.main.bounds.height - 100
    
    var body: some View {
        ZStack{
            Color.orange
            Swipe()
                .cornerRadius(20)
                .padding(15)
                .offset(y:size)
            
            .gesture( DragGesture()
                .onChanged({value in
                    if value.translation.height > 0{
                        self.size = value.translation.height
                    }
                    else{
                        let temp = UIScreen.main.bounds.height - 100
                        self.size = temp + value.translation.height
                    }
                })
                .onEnded({value in
                    if value.translation.height > 0{
                        if value.translation.height > 200{
                            self.size = UIScreen.main.bounds.height - 100
                        }
                        else{
                            self.size = 15
                        }
                    }
                    else {
                        if value.translation.height < -200{
                            self.size = 15
                        }
                        else{
                            self.size = UIScreen.main.bounds.height - 100
                        }
                    }
                })
            )
            .animation(.spring())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Swipe: View{
    var body: some View{
        VStack{
            
            VStack{
                Text("Swipe up to see more")
                    .fontWeight(.heavy)
                    .padding([.top, .bottom], 15)
            }
            
            HStack{
                Spacer()
                Text("Top")
                    .fontWeight(.heavy)
                    .padding()
            }
            
            Spacer()
            Text("Bottom")
                .fontWeight(.heavy)
                .padding()
        }
        .background(Color.white)
    }
}
