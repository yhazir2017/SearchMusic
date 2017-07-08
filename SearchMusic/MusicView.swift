//
//  MusicView.swift
//  SearchMusic
//
//  Created by YILDIRAY HAZIR on 6/23/17.
//  Copyright © 2017 interview. All rights reserved.
//

import UIKit

class MusicView: UIView {
   
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    func addDataToMusicView (_ album:Album) {
        ItunesConnection.getImage(url: album.artworkURL) { (image) in
            DispatchQueue.main.async {
                if let image = image {
                    self.artworkImageView.image = image
                }
            }
        }
       
        DispatchQueue.main.async {
            self.titleLabel.text = album.title
            self.artistLabel.text = album.artist
            self.genreLabel.text = album.genre
        }
    }

}

