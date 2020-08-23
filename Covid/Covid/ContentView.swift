//
//  ContentView.swift
//  Covid
//
//  Created by Omar Alejandro Robles Altamirano on 23/08/20.
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
    var body: some View{
        
        VStack{
            HStack{
                VStack(alignment: .leading, spacing: 15){
                    Text("Date")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("COVID - 19 Cases")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("361,987")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.white)
                }
                Button(action:{
                    
                }){
                    Image(systemName: "arrow.clockwise")
                        .font(.title)
                        .foregroundColor(.white)
                }
            }
            .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 18)
            .padding()
            .padding(.bottom, 80)
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
        .background(
            Color.black.opacity(0.2)
                .edgesIgnoringSafeArea(.all)
        )
    }
}
