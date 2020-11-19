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
        @State var user = [Content]()
    
        var body: some View {
                List(user, id: \.id) { item in
                    Text("\(item.name)").font(.body)
                    Text("\(item.company.catchPhrase)").font(.subheadline)
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

struct Content: Codable {
    let id: Int
    let name, username, email,phone, website: String
    let address: addr
    let company: compAddr

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case address
        case phone
        case website
        case company
    }
}

struct addr: Codable {
    let street, suite, city, zipcode: String
    let geo: geoLatLon
}

struct geoLatLon: Codable {
    let lat, lng: String
}


struct compAddr: Codable {
    let name, catchPhrase, bs: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
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
