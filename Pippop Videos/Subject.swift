//
//  Subject.swift
//  Pippop Videos
//
//  Created by Alex Thompson on 13/01/2016.
//  Copyright © 2016 Alex Thompson. All rights reserved.
//

import Foundation

class Subject {
    
    var title = String()
    var imageUrl = String()
    var videos = [Video]()
    
    init(_title: String, _imageUrl: String, _videos: [Video]){
        self.title = _title
        self.imageUrl = _imageUrl
        self.videos = _videos
    }
}

    