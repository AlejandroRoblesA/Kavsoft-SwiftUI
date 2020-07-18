//
//  ContentView.swift
//  Location Sharing
//
//  Created by Omar Alejandro Robles Altamirano on 09/07/20.
//  Copyright © 2020 Omar Alejandro Robles Altamirano. All rights reserved.
//

import SwiftUI
import Firebase
import CoreLocation
import MapKit

struct ContentView: View {
    
    @State var name = ""
    @ObservedObject var observer = Observer()
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                TextField("Enter your name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if name != ""{
                    NavigationLink(destination: MapView(name: self.name, geopoints: self.observer.data["data"] as! [String : GeoPoint]).navigationBarTitle("", displayMode: .inline)){
                            Text("Share Location")
                    }
                }
            }
            .padding()
            .navigationBarTitle("Location sharing")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MapView: UIViewRepresentable{
    
    var name = ""
    var geopoints : [String: GeoPoint]
    
    func makeCoordinator() -> MapView.Coordinator {
        return MapView.Coordinator(parent1: self)
    }
    
    
    let map = MKMapView()
    let manager = CLLocationManager()
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        
        manager.delegate = context.coordinator
        manager.startUpdatingLocation()
        map.showsUserLocation = true
        let center = CLLocationCoordinate2D(latitude: 19.55642, longitude: -98.92836)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        map.region = region
        manager.requestWhenInUseAuthorization()
        
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        
        for i in geopoints{
            
            if i.key != name{
                let point = MKPointAnnotation()
                point.coordinate = CLLocationCoordinate2D(latitude: i.value.latitude, longitude: i.value.longitude)
                point.title = i.key
                uiView.removeAnnotations(uiView.annotations)
                uiView.addAnnotation(point)
            }
            
            
        }
    }
    
    class Coordinator: NSObject, CLLocationManagerDelegate{
        
        var parent: MapView
        
        init(parent1: MapView) {
            parent = parent1
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .denied{
                print("denied")
            }
            if status == .authorizedWhenInUse{
                print("authorized")
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let last = locations.last
            
            let db = Firestore.firestore()
            
            db.collection("locations").document("sharing").setData(["updates" : [self.parent.name : GeoPoint(latitude: (last?.coordinate.latitude)!, longitude: (last?.coordinate.longitude)!)]], merge: true){ error in
                
                if error != nil{
                    print((error?.localizedDescription)!)
                    return
                }
                print("success")
            }
        }
    }
}

class Observer: ObservableObject{
    
    @Published var data = [String: Any]()
    
    init() {
        let db = Firestore.firestore()
        
        db.collection("locations").document("sharing").addSnapshotListener{ snap , error in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            
            let updates = snap?.get("updates") as! [String : GeoPoint]
            self.data["data"] = updates
        }
    }
}
