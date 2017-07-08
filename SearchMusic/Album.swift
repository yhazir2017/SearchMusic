//
//  Album.swift
//  SearchMusic
//
//  Created by YILDIRAY HAZIR on 6/21/17.
//  Copyright © 2017 interview. All rights reserved.
//


import UIKit

class Album: NSObject {
    
    var title:String!
    var artist:String!
    var genre:String!
    var artworkURL:String!
    
    init (title:String, artist:String, genre:String, artworkURL:String){
        super.init()
        
        self.title = title
        self.artist = artist
        self.genre = genre
        self.artworkURL = artworkURL
        
    }
    
    
}
