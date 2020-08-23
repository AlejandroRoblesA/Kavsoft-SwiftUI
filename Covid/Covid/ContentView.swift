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
            HStack(alignment: .top){
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
                
                Spacer()
                
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
            .background(Color.red)
            
            HStack(spacing: 15){
                
                VStack(alignment: .leading, spacing: 15){
                    Text("Deaths")
                        .foregroundColor(Color.black.opacity(0.5))
                    Text("3667")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }
                .padding(30)
                .background(
                    Color.white
                        .cornerRadius(12)
                )
                
                VStack(alignment: .leading, spacing: 15){
                    Text("Recovered")
                        .foregroundColor(Color.black.opacity(0.5))
                    Text("3667")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 30)
                .background(
                    Color.white
                        .cornerRadius(12)
                )
            }
            .offset(y: -60)
            .padding(.bottom, -60)
            .zIndex(25)
            
            VStack(alignment: .center, spacing: 15){
                Text("Active cases")
                    .foregroundColor(Color.black.opacity(0.5))
                Text("3667")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)
            }
            
            .padding(30)
            .background(
                Color.white
                    .cornerRadius(12)
            )
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 15){
                    ForEach(1...15, id:\.self){ i in
                        CellView()
                    }
                }
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .background(
            Color.black.opacity(0.2)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct CellView: View{
    var body: some View{
        VStack(alignment: .leading, spacing: 15){
            Text("USA")
                .fontWeight(.bold)
            HStack(spacing: 22){
                VStack(alignment: .leading, spacing: 12){
                    Text("Active Cases")
                        .font(.title)
                    Text("222,111")
                        .font(.title)
                }
                
                VStack(alignment: .leading, spacing: 12){
                    VStack(alignment: .leading, spacing: 10){
                        Text("Deaths")
                        
                        Text("123")
                            .foregroundColor(.red)
                    }
                    Divider()
                    VStack(alignment: .leading, spacing: 10){
                        Text("Recovered")
                        
                        Text("123")
                            .foregroundColor(.green)
                    }
                    Divider()
                    VStack(alignment: .leading, spacing: 10){
                        Text("Critial")
                        
                        Text("123")
                            .foregroundColor(.yellow)
                    }
                    
                }
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 30)
        .background(Color.white)
        .cornerRadius(20)
    }
}
