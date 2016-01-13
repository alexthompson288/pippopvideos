//
//  Utility.swift
//  Pippop Videos
//
//  Created by Alex Thompson on 13/01/2016.
//  Copyright © 2016 Alex Thompson. All rights reserved.
//

import Foundation
//
//  Utility.swift
//  lettersounds
//
//  Created by Alex Thompson on 08/01/2016.
//  Copyright © 2016 Alex Thompson. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    
        
    class func checkIfFileExistsAtPath(filepath: String) -> Bool {
        var filemgr = NSFileManager.defaultManager()
        if filemgr.fileExistsAtPath(filepath){
            print("File does exist at \(filepath)")
            return true
        } else {
            print("File does NOT exist at \(filepath)")
            return false
        }
    }

    
    
    static func getRandomNumberInRange(max: Int) -> Int {
        let newInt = arc4random_uniform(UInt32(max)) + UInt32(1)
        return Int(newInt)
    }
    
    class func createFilePathInDocsDir(filename: String) -> String {
        var filepath  = "\(Homedir)/\(filename)"
        return filepath
    }
    
    static func loadData(){
        let defaults =  NSUserDefaults.standardUserDefaults()
        video_data.removeAll()
        print("Nothing in user defaults. Loading data from JSON..")
        if let path = NSBundle.mainBundle().pathForResource(jsonFileName, ofType: "json")
        {
            if let jsonData = NSData(contentsOfFile: path)
            {
                if let jsonResult: NSDictionary = try?NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                {
                    if let subjectsArray = jsonResult["subjects"] as? NSArray {
                        for mySubject in subjectsArray {
                            let thisTitle = mySubject["title"] as! String
                            let thisImageUrl = mySubject["url_image_local"] as! String
                            var newVideosArray = [Video]()
                            if let videosArray = mySubject["pipisodes"] as? NSArray {
                                
                                for thisVideo in videosArray {
                                    let thisTitle = thisVideo["title"] as! String
                                    let thisOverview = thisVideo["learning_objective"] as! String
                                    let thisImageUrl = thisVideo["url_image_local"] as! String
                                    let thisVideoUrlLocal = thisVideo["url_image_local"] as! String
                                    let thisVideoUrlRemote = thisVideo["url_video_remote"] as! String
                                    let thisNewVideo = Video(_title: thisTitle, _overview: thisOverview, _imageUrl: thisImageUrl, _videoUrlLocal: thisVideoUrlLocal, _videoUrlRemote: thisVideoUrlRemote)
                                    newVideosArray.append(thisNewVideo)
                                    
                                }
                            }
                            var thisNewSubject = Subject(_title: thisTitle, _imageUrl: thisImageUrl, _videos: newVideosArray)
                            video_data.append(thisNewSubject)
                            
                        }
                        print("We have \(video_data.count) subjects")
                    }
                }
            }
        }
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: startIndex.advancedBy(r.startIndex), end: startIndex.advancedBy(r.endIndex)))
    }
}



extension UIColor
{
    convenience init(red: Int, green: Int, blue: Int)
    {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}

extension CollectionType {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 2.0)
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate
        }
        self.layer.addAnimation(rotateAnimation, forKey: nil)
    }
}

