//
//  ContentView.swift
//  ArraySum
//
//  Created by steve groves on 14/06/2020.
//  Copyright © 2020 steve groves. All rights reserved.
//
// https://medium.com/@rbreve/displaying-a-list-with-swiftui-from-a-remote-json-file-6b4e4280a076
//

import SwiftUI
import Combine

struct ContentView: View {
        @State private var results = [Result]()
        @State private var sumAge: Int = 0
        var body: some View {
            
                List(results, id: \.id) { item in
                    Text("Count:\(self.increaseIndex(for: self.sumAge))  ")
                    VStack(alignment: .leading) {
                        Text("Age: \(item.age) years")
                        Text(item.first_name + " " + item.last_name)
                        
                    }
                }.onAppear(perform: loadData)
        }
    
    func increaseIndex(for sumAge: Int) -> Int {
        self.sumAge += 1
        return self.sumAge
    }
    
    func loadData() {
        guard let url = URL(string: "https://learnappmaking.com/ex/users.json") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let d = data {
                if let decodedResponse = try? JSONDecoder().decode([Result].self, from: d) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        self.results = decodedResponse
                    }
                    // everything is good, so we can exit
                    return
                }
            }
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct Result: Codable, Identifiable {
    let id = UUID()
    let first_name: String
    let last_name: String
    let age: Int
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
