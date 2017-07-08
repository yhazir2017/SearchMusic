//
//  ItunesConnection.swift
//  SearchMusic
//
//  Created by YILDIRAY HAZIR on 6/21/17.
//  Copyright © 2017 interview. All rights reserved.
//

import UIKit

class ItunesConnection: NSObject {
    
    class func getAlbumForString(searchString:String, completionHandler:@escaping (Album)->()){
        
        let escapedString = searchString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlHostAllowed)
        let addressString = "https://itunes.apple.com/search?term=\(escapedString!)&media=music"
        let urlString = URL(string: addressString)
        
        let task = URLSession.shared.dataTask(with: urlString! as URL, completionHandler: {
            (data, response, error) -> Void in
            if error == nil {
                
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    //Store response in NSDictionary for easy access
                    let itunesDict = parsedData as? NSDictionary
                    print(itunesDict!)
                    
                    let resultsArray = itunesDict?.object(forKey: "results") as! [Dictionary<String,AnyObject>]
                    
                    if resultsArray.count > 0 {
                        if let resultsDict = resultsArray.first {
                            let artist = resultsDict["artistName"] as! String
                            let artworkURL = resultsDict["artworkUrl100"] as! String
                            let albumTitle = resultsDict["collectionName"] as! String
                            let genre = resultsDict["primaryGenreName"] as! String
                            
                            let album = Album(title: albumTitle, artist: artist, genre: genre, artworkURL: artworkURL)
                            
                            completionHandler(album)
                        }
                    }
                    
                    
                } catch let error as NSError {
                    print("Details of JSON parsing error:\n \(error)")
                }
            }
        })
        task.resume()
    }
    
    class func getImage(url:String, completionHandler: @escaping (UIImage?)->()) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            // The download has finished.
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                // No errors was found.
                // It would be weird if we didn't have a response, so check for that too.
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        let image = UIImage(data: imageData)
                        // Do something with your image.
                        completionHandler(image)
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        task.resume()
    }
}


