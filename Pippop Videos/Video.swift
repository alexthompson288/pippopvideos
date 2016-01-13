//
//  Video.swift
//  Pippop Videos
//
//  Created by Alex Thompson on 13/01/2016.
//  Copyright © 2016 Alex Thompson. All rights reserved.
//

import Foundation
import UIKit

class Video {
    var title = String()
    var overview = String()
    var imageUrl = String()
    var videoUrlLocal = String()
    var videoUrlRemote = String()
    
    
    init(_title: String, _overview: String, _imageUrl: String, _videoUrlLocal: String, _videoUrlRemote: String){
        self.title = _title
        self.overview = _overview
        self.imageUrl = _imageUrl
        self.videoUrlLocal = _videoUrlLocal
        self.videoUrlRemote = _videoUrlRemote
    }
    
    func returnBadgeImage() -> UIImage {
        var string = String()
        if imageUrl == "songs_ifyou'rehappy"{
            string = "badge_songs_ifyourehappy"
        } else {
            string = "badge_\(imageUrl)"
            print("Image string: \(string)")
        }
        
        return UIImage(named: string)!
    }
    
    func returnWideImage() -> UIImage {
        var string = String()
        if imageUrl == "songs_ifyou'rehappy"{
            string = "img_songs_ifyourehappy"
        } else {
            string = "img_\(imageUrl)"
            print("Image string: \(string)")
        }
        return UIImage(named: string)!
    }
    
    func returnVideoLocalUrl() -> String {
        return "\(imageUrl).mp4"
    }
}