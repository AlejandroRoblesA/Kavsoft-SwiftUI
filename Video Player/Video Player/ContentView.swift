//
//  ContentView.swift
//  Video Player
//
//  Created by Omar Alejandro Robles Altamirano on 22/07/20.
//  Copyright © 2020 Omar Alejandro Robles Altamirano. All rights reserved.
//

import SwiftUI
import AVKit

struct ContentView: View {
    var body: some View {
        VStack{
            Player()
                .frame(height: UIScreen.main.bounds.height/3)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct Player: UIViewControllerRepresentable{
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<Player>) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        let url = "https://www.youtube.com/watch?v=VOZ6MIvI790&list=RDVOZ6MIvI790&start_radio=1"
        let player1 = AVPlayer(url: URL(string: url)!)
        controller.player = player1
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<Player>) {
        
    }
}
