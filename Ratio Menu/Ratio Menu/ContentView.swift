//
//  ContentView.swift
//  Ratio Menu
//
//  Created by Omar Alejandro Robles Altamirano on 22/08/20.
//

import SwiftUI

var data = ["Revelance", "Newest", "Proce (low to hight)", "Price (hight to low)", "Sort by Specs", "Sort by Storage"]

struct ContentView: View {
    
    @State var selected = ""
    @State var show = false
    
    var body: some View {
        ZStack{
            
            VStack{
                
                Button(action: {
                    self.show.toggle()
                }){
                    Text("Open")
                        .padding(.vertical)
                        .padding(.horizontal, 25)
                        .foregroundColor(.white)
                }
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.orange, Color.pink]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                )
                .clipShape(Capsule())
                
                Text(self.selected)
                    .padding(.top)
            }
            
            
            
            
            VStack{
                Spacer()
                RadioButtons(selected: $selected, show: $show)
                    .offset(y: self.show ?
                            (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 15 :
                                UIScreen.main.bounds.height
                    )
            }
            .background(
                Color(
                    UIColor.label.withAlphaComponent(self.show ? 0.2 : 0)
                )
                .edgesIgnoringSafeArea(.all)
            )
        }
        .background(Color(.lightGray))
        .ignoresSafeArea(.all)
        .animation(.default)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct RadioButtons: View{
    
    @Binding var selected: String
    @Binding var show: Bool
    
    var body: some View{
        
        VStack(alignment: .leading, spacing: 20) {
            Text("Filter by")
                .font(.title)
                .padding(.top)
            
            ForEach(data, id:\.self){ i in
                Button(action: {
                    self.selected = i
                }){
                    HStack{
                        Text(i)
                        Spacer()
                        
                        ZStack{
                            Circle()
                                .fill(self.selected == i ?
                                    Color(.red) :
                                    Color.black.opacity(0.2)
                                    
                                )
                                .frame(width:18, height: 18)
                            
                            if self.selected == i {
                                Circle().stroke(Color(.red), lineWidth: 4)
                                    .frame(width: 25, height: 25)
                            }
                        }
                    }
                    .foregroundColor(.black)
                }
                .padding(.top)
            }
            HStack{
                Spacer()
                Button(action: {
                    self.show.toggle()
                }){
                    Text("Continue")
                        .padding(.vertical)
                        .padding(.horizontal, 25)
                        .foregroundColor(.white)
                }
                .background(
                    
                    self.selected != "" ?
                    
                    LinearGradient(gradient: Gradient(colors: [Color.orange, Color.pink]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/) :
                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.2), Color.black.opacity(0.2)]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                )
                .clipShape(Capsule())
                .disabled(self.selected != "" ? false : true)
            }
            .padding(.top)
        }
        .padding(.vertical)
        .padding(.horizontal, 25)
        .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 15)
        .background(Color(.white))
        .cornerRadius(25)
    }
}
