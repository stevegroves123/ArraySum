//
//  ArrayModel.swift
//  ArraySum
//
//  Created by steve groves on 19/11/2020.
//  Copyright © 2020 steve groves. All rights reserved.
//

import Foundation

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
