//
//  ContentView.swift
//  ArraySum
//
//  Created by steve groves on 14/06/2020.
//  Copyright © 2020 steve groves. All rights reserved.
//

import SwiftUI
//import Combine

struct ContentView: View {
        @State var user = [Content]()
    
        var body: some View {
                List(user, id: \.id) { item in
                    Text("\(item.name)").font(.body)
                    Text("\(item.email)").font(.subheadline).foregroundColor(.blue)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
