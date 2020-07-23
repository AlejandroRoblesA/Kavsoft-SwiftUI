//
//  ContentView.swift
//  ImagePicker
//
//  Created by Omar Alejandro Robles Altamirano on 22/07/20.
//  Copyright © 2020 Omar Alejandro Robles Altamirano. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var imageData = Data.init(count: 0)
    @State var shown = false
    
    var body: some View {
        VStack{
            
            if imageData.count != 0{
                Image(uiImage: UIImage(data: imageData)!)
                    .resizable()
                    .frame(height:300)
                    .padding()
                    .cornerRadius(20)
            }
            
            Button(action: {
                self.shown.toggle()
            }){
                Text("Select Image")
            }
            .sheet(isPresented: $shown, content: {
                Picker(shown: self.$shown, imageData: self.$imageData)
            })
        }
        .animation(.spring())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Picker: UIViewControllerRepresentable{
    
    @Binding var shown: Bool
    @Binding var imageData: Data
    
    func makeCoordinator() -> Picker.Coordinator {
        return Coordinator(imageData1: $imageData, shown1: $shown)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<Picker>) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<Picker>) {
        
    }
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        
        @Binding var imageData: Data
        @Binding var shown: Bool
        
        init(imageData1: Binding<Data>, shown1: Binding<Bool>) {
            _imageData = imageData1
            _shown = shown1
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            shown.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            imageData = image.jpegData(compressionQuality: 80)!
            shown.toggle()
        }
        
    }
}
