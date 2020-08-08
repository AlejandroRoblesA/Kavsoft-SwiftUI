//
//  ContentView.swift
//  Circular Loader
//
//  Created by Omar Alejandro Robles Altamirano on 08/08/20.
//  Copyright © 2020 Omar Alejandro Robles Altamirano. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var percent: CGFloat = 0
    
    var body: some View {
        VStack{
            Loader(percent: $percent)
            
            HStack{
                
                ForEach(0..<101){ i in
                    if (i%25 == 0){
                        HStack{
                            Button(action: {
                                self.percent = CGFloat(i)
                            }){
                                Text("\(i) %")
                            }
                        }
                    }
                }
            }
            .padding(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Loader: View{
    @Binding var percent: CGFloat
    var colors: [Color] = [.red, .green, .orange, .pink, .yellow, .purple, .blue]
    
    var body: some View{
        ZStack{
            
            Circle()
                .fill(Color.white)
                .frame(width: 150, height: 150)
                .overlay(
                    Circle()
                        .trim(from: 0, to: percent * 0.01)
                        .stroke(style: StrokeStyle(
                                lineWidth: 25,
                                lineCap: .round,
                                lineJoin: .round
                            )
                        )
                        .fill(
                            AngularGradient(gradient: .init(colors: colors),
                                              center: .center,
                                              startAngle: .zero,
                                              endAngle: .init(degrees: 360)
                                            )
                        )
                )
                .animation(.spring(response: 1.0, dampingFraction: 1.0, blendDuration: 1.0))
            
            Text(String(format: "%.2f", percent) + " %")
                .font(.system(size: 20))
                .fontWeight(.heavy)
        }
    }
}
