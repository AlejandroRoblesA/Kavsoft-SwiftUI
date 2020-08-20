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
        
        let product = "iphone"
        let productsNumber = "20"
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: "https://api.ektdevelopers.com/_graphql?query=query%20getProductList(%0A%20%20%24after%3A%20Cursor%0A%20%20%24first%3A%20Int%0A%20%20%24query%3A%20String%0A%20%20%24defaultFilter%3A%20String%0A%20%20%24clusterId%3A%20String%0A%20%20%24useAutocomplete%3A%20Boolean%0A%20%20%24filterMatrix%3A%20%5B%5BFilter%5D%5D%0A%20%20%24sort%3A%20%5BSort%5D%0A%20%20%24minPrice%3A%20Float%0A%20%20%24maxPrice%3A%20Float%0A)%20%7B%0A%20%20productList(%0A%20%20%20%20after%3A%20%24after%0A%20%20%20%20first%3A%20%24first%0A%20%20%20%20query%3A%20%24query%0A%20%20%20%20%0A%20%20%20%20defaultFilter%3A%20%24defaultFilter%0A%20%20%20%20clusterId%3A%20%24clusterId%0A%20%20%20%20useAutocomplete%3A%20%24useAutocomplete%0A%20%20%20%20filterMatrix%3A%20%24filterMatrix%0A%20%20%20%20sort%3A%20%24sort%0A%20%20%20%20minPrice%3A%20%24minPrice%0A%20%20%20%20maxPrice%3A%20%24maxPrice%0A%20%20)%20%7B%0A%20%20%20%20edges%20%7B%0A%20%20%20%20%20%20node%20%7B%0A%20%20%20%20%20%20%20%20...product%0A%20%20%20%20%20%20%7D%0A%20%20%20%20%7D%0A%20%20%7D%0A%7D%0A%0Afragment%20product%20on%20Product%20%7B%0A%20%20image%0A%20%20name%0A%20%20lastPriceFormated%0A%20%20priceFormated%0A%20%20weeklyData%7B%0A%20%20%20%20amount%0A%20%20%7D%0A%7D%0A&variables=%7B%0A%20%20%22after%22%3A%20null%2C%0A%20%20%22first%22%3A%20\(productsNumber)%2C%0A%20%20%22query%22%3A%20%22\(product)%22%2C%0A%20%20%22defaultFilter%22%3A%20null%2C%0A%20%20%22clusterId%22%3A%20null%2C%0A%20%20%22useAutocomplete%22%3A%20false%2C%0A%20%20%22filterMatrix%22%3A%20%5B%5D%2C%0A%20%20%22sort%22%3A%20%5B%5D%2C%0A%20%20%22minPrice%22%3A%200%2C%0A%20%20%22maxPrice%22%3A%20999%0A%7D")!){ (data, response, error) in
            do{
                            
                            guard let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary else { return }
            //                let fetch = try JSONDecoder().decode([DataType].self, from: data!)
            //
            //                DispatchQueue.main.async {
            //                    self.jsonData = fetch
            //                }
                            print(json)
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
