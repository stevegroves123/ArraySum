//
//  ContentView.swift
//  ArraySum
//
//  Created by steve groves on 14/06/2020.
//  Copyright © 2020 steve groves. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
        @State private var user = [Content]()
    
        var body: some View {
                List(user, id: \.id) { item in
                    Text("\(item.name)")
                }.onAppear(perform: loadData)
        }
    
    
    func loadData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        print(request)
        URLSession.shared.dataTask(with: request) { data, response, error in
            print(response as Any)
            print("")
            print(error as Any)
            if let d = data {
                print("It made it here")
                if let decodedResponse = try? JSONDecoder().decode([Content].self, from: d) {
                    // we have good data – go back to the main thread
                    print("dispatched")
                    DispatchQueue.main.async {
                        // update our UI
                        self.user = decodedResponse
                    }
                    // everything is good, so we can exit
                    print("It all went well")
                    return
                }
                print("it went wrong somewhere")
            }
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct Content: Decodable  {
    let id = UUID()
    let name: String
    let username: String
    let email: String
    let address: addr
    let phone: String
    let website: String
    let company: compAddr

    enum CodingKeys: String, CodingKey {
        case name
        case username
        case email
        case address
        case phone
        case website
        case company
    }
}

struct addr {
    let id = UUID()
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: geoLatLon
}

struct geoLatLon {
    let id = UUID()
    let lat: String
    let lon: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct compAddr {
    let name: String
    let catchPhrase: String
    let bs: String
}

/*
 {
   "id": 1,
   "name": "Leanne Graham",
   "username": "Bret",
   "email": "Sincere@april.biz",
   "address": {
     "street": "Kulas Light",
     "suite": "Apt. 556",
     "city": "Gwenborough",
     "zipcode": "92998-3874",
     "geo": {
       "lat": "-37.3159",
       "lng": "81.1496"
     }
   },
   "phone": "1-770-736-8031 x56442",
   "website": "hildegard.org",
   "company": {
     "name": "Romaguera-Crona",
     "catchPhrase": "Multi-layered client-server neural-net",
     "bs": "harness real-time e-markets"
   }
 }
 */
