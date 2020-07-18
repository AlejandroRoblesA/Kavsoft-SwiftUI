//
//  ContentView.swift
//  AdMob Banner
//
//  Created by Omar Alejandro Robles Altamirano on 18/07/20.
//  Copyright © 2020 Omar Alejandro Robles Altamirano. All rights reserved.
//

import SwiftUI
import GoogleMobileAds

struct ContentView: View {
    
    
    
    var body: some View {
//        AdView()
//            .frame(width: 50, height: 50)
        
        AdInterstatial()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct AdView: UIViewRepresentable{
    
    func makeUIView(context: UIViewRepresentableContext<AdView>) -> GADBannerView {
        let banner = GADBannerView(adSize: kGADAdSizeBanner)
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(GADRequest())
        return banner
    }
    
    func updateUIView(_ uiView: GADBannerView, context: UIViewRepresentableContext<AdView>) {
        
    }
}

struct AdInterstatial: View{
    
    @State var interstatial: GADInterstitial!
    
    var body: some View{
        Button(action: {
            
            if self.interstatial.isReady{
                
                
                let root = UIApplication.shared.windows.first?.rootViewController
                self.interstatial.present(fromRootViewController: root!)
                
            }
            else{
                print("Not Ready")
            }
        }){
            Text("Show")
        }
        
        .onAppear{
            self.interstatial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
            let request = GADRequest()
            self.interstatial.load(request)
        }
    }
}
