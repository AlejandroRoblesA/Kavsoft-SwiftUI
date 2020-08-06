//
//  ContentView.swift
//  Json Parsing
//
//  Created by Omar Alejandro Robles Altamirano on 06/08/20.
//  Copyright © 2020 Omar Alejandro Robles Altamirano. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @ObservedObject var getData = JsonData()
    
    var body: some View {
        NavigationView{
            List(getData.jsonData){ i in
                
                ListRow(url: i.avatar_url, name: i.login)
                
            }
        .navigationBarTitle("JSON Parsing")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


class JsonData: ObservableObject{
    @Published  var jsonData = [DataType]()
    
    init (){
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: "https://api.github.com/users/hadley/orgs")!){ (data, response, error) in
            do{
                let fetch = try JSONDecoder().decode([DataType].self, from: data!)
                
                DispatchQueue.main.async {
                    self.jsonData = fetch
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
        .resume()
    }
}

struct DataType: Identifiable, Decodable {
    
    var id: Int
    var login: String
    var node_id: String
    var avatar_url: String
    
}

struct ListRow: View{
    
    var url: String
    var name: String
    
    var body: some View{
        
        HStack{
            AnimatedImage(url: URL(string: url))
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .shadow(radius: 20)
            Text(name)
                .fontWeight(.heavy)
                .padding(.leading, 10)
        }
        .padding(.all, 5)
    }
}
