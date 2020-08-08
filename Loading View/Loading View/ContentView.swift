//
//  ContentView.swift
//  Loading View
//
//  Created by Omar Alejandro Robles Altamirano on 06/08/20.
//  Copyright © 2020 Omar Alejandro Robles Altamirano. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var show = false
    
    var body: some View {
        
        ZStack{
            NavigationView{
                List(0..<10) {_ in
                    Text("Alejandro")
                }
                .navigationBarTitle("Home")
                .navigationBarItems(trailing:
                    Button(action: {
                        self.show.toggle()
                    }){
                        Text("Show")
                    }
                )
            }
            .blur(radius: self.show ? 15 : 0)
            if show {
                Loading()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Loading: View{
    
    var body: some View{
        ZStack{
            BlurView()
            
            VStack{
                Indicator()
                Text("Please Wait")
                    .foregroundColor(.white)
                    .padding(.top, 8)
            }
        }
        .frame(width: 120, height: 120)
        .cornerRadius(8)
    }
}

struct BlurView: UIViewRepresentable{
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIVisualEffectView {
        let effect = UIBlurEffect(style: .systemMaterialDark)
        let view = UIVisualEffectView(effect: effect)
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<BlurView>) {
        
    }
}

struct Indicator: UIViewRepresentable{
    
    func makeUIView(context: UIViewRepresentableContext<Indicator>) -> UIActivityIndicatorView {
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = UIColor.white
        indicator.startAnimating()
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Indicator>) {
        
    }
}
