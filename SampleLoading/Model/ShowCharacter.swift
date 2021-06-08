//
//  ShowCharacter.swift
//  SampleLoading
//
//  Created by Rafael Costa on 08/06/21.
//

import Foundation


//"id": 361,
//"name": "Toxic Rick",
//"status": "Dead",
//"species": "Humanoid",
//"type": "Rick's Toxic Side",
//"gender": "Male",
//"origin": {
//  "name": "Alien Spa",
//  "url": "https://rickandmortyapi.com/api/location/64"
//},
//"location": {
//  "name": "Earth",
//  "url": "https://rickandmortyapi.com/api/location/20"
//},
//"image": "https://rickandmortyapi.com/api/character/avatar/361.jpeg",
//"episode": [
//  "https://rickandmortyapi.com/api/episode/27"
//],
//"url": "https://rickandmortyapi.com/api/character/361",
//"created": "2018-01-10T18:20:41.703Z"
//},

struct ShowCharacter: Codable {
    let id: Int
    let name: String
    let species: String
    
    let image: String
}