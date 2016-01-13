//
//  VideoShowController.swift
//  Pippop Videos
//
//  Created by Alex Thompson on 13/01/2016.
//  Copyright © 2016 Alex Thompson. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Parse
import Alamofire
import MediaPlayer
import ReachabilitySwift

class VideoShowController: UIViewController {
    
    @IBOutlet weak var progressBarVideo: UIProgressView!
    @IBOutlet weak var imageVideoImage: UIImageView!
    @IBOutlet weak var labelVideoDescription: UILabel!
    @IBOutlet weak var buttonDownload: UIButton!
    @IBOutlet weak var buttonPlay: UIButton!
    
    var currentVideo:Video!
    var videoIsLocal = false
    var video_URL: NSURL!
    var isDownloading = false
    var moviePlayer: MPMoviePlayerViewController!
    var alamoRequest: Alamofire.Request?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoIsLocal = isVideoLocalCheck()
        setDownloadButtonValue()
        imageVideoImage.image = currentVideo.returnWideImage()
        imageVideoImage.layer.cornerRadius = 4
        imageVideoImage.clipsToBounds = true
        labelVideoDescription.text = currentVideo.overview
        self.title = currentVideo.title
        progressBarVideo.hidden = true
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Phone :
            labelVideoDescription.font = iPhoneFontMediumSmall
        case .Pad :
            labelVideoDescription.font = iPadFont
        default: labelVideoDescription.font = iPhoneFont
        }
        progressBarVideo.layer.cornerRadius = 12
        progressBarVideo.layer.masksToBounds = true
        let gesture = UITapGestureRecognizer(target: self, action: Selector("playVideo"))
        imageVideoImage.addGestureRecognizer(gesture)
    }
    
    @IBAction func ActionDownload(sender: AnyObject) {
        let dimensions = [
            "video" : "\(currentVideo.title)",
            "scene" : "Video"
        ]
        PFAnalytics.trackEvent("download_video", dimensions: dimensions)
        
        if videoIsLocal {
            deleteVideo()
        } else {
            downloadVideo()
        }
    }
    
    
    @IBAction func ActionPlay(sender: AnyObject) {
        playVideo()
    }
    
    
    func setDownloadButtonValue(){
        
        if videoIsLocal {
            buttonDownload.setTitle("Delete", forState: .Normal)
        } else {
            buttonDownload.setTitle("Download", forState: .Normal)
        }
    }
    
    func deleteVideo(){
        print("About to delete video")
        let filePath = Utility.createFilePathInDocsDir(currentVideo.videoUrlLocal)
        let fileManager = NSFileManager.defaultManager()
        do{
            try fileManager.removeItemAtPath(filePath)
            
        } catch {
            print("Unable to delete video")
        }
        videoIsLocal = false
        setDownloadButtonValue()
    }
    
    func playVideo(){
        let dimensions = [
            "letter" : "\(currentVideo.title)",
            "scene" : "Video"
        ]
        PFAnalytics.trackEvent("watch_video", dimensions: dimensions)

        if videoIsLocal == true {
            //                println("Play video! Path is \(url_video_local)")
            if let directoryURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0] as? NSURL {
                video_URL = directoryURL.URLByAppendingPathComponent(currentVideo.returnVideoLocalUrl())
                //                    println("Total local video url is \(video_URL)")
            } else {
                //                    println("Problem finding local docs folder...")
            }
        }
        else {
            video_URL = NSURL(string: currentVideo.videoUrlRemote)!
        }
        self.moviePlayer = MPMoviePlayerViewController(contentURL: video_URL)
        self.moviePlayer.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        presentMoviePlayerViewControllerAnimated(self.moviePlayer)

    }
    
    func downloadVideo(){
        let reachability: Reachability
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
            if reachability.isReachable(){
                dispatch_async(dispatch_get_main_queue()){
                    self.isDownloading = true
                    self.progressBarVideo.hidden = false
                    self.progressBarVideo.setProgress(0.0, animated: true)
                    //                self.CancelDownloadLabel.hidden = false
                }
                
                let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
                Alamofire.download(.GET, currentVideo.videoUrlRemote, destination: destination)
                    .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
                        dispatch_async(dispatch_get_main_queue()) {
                            self.progressBarVideo.setProgress(Float(totalBytesRead) / Float(totalBytesExpectedToRead), animated: true)
                        }
                    }
                    .response { _, _, _, error in
                        if let error = error {
                            print("Failed with error: \(error)")
                        } else {
                            print("Downloaded file successfully")
                            
                            self.progressBarVideo.hidden = true
                            self.videoIsLocal = true
                            self.setDownloadButtonValue()
                            self.progressBarVideo.setProgress(0.0, animated: false)
                            
                        }
                }
            } else {
                print("No Internet")
            }
            
        } catch {
            print("Unable to create Reachability")
            return
        }
        
    }
    
    func isVideoLocalCheck() -> Bool {
        //    CHECK IF LOCAL VERSION EXISTS AND SET HASLOCALVIDEO VARIABLE
        let filePath = Utility.createFilePathInDocsDir(currentVideo.returnVideoLocalUrl())
        print("Path: \(filePath)")
        let fileExists = Utility.checkIfFileExistsAtPath(filePath)
        if fileExists {
            //            CREATE URL LOCATION AND SET DO NOT BACKUP FLAG
            var totalurl = NSURL()
            if let directoryURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0] as? NSURL {
                //                println("Video filename... \(video_filename)")
                totalurl = directoryURL.URLByAppendingPathComponent(currentVideo.returnVideoLocalUrl())
                
            }
            self.addSkipBackupAttributeToItemAtURL(totalurl)
            return true
        } else {
            return false
        }
        
    }
    
    
    func addSkipBackupAttributeToItemAtURL(URL:NSURL) ->Bool{
        do {
            let success = try URL.setResourceValue(true, forKey: NSURLIsExcludedFromBackupKey)
            return true
        }
        catch {
            return false
        }
    }
    
}