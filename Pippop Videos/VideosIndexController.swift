//
//  VideosIndexController.swift
//  Pippop Videos
//
//  Created by Alex Thompson on 13/01/2016.
//  Copyright © 2016 Alex Thompson. All rights reserved.
//
import UIKit
import AVFoundation
import Parse
import Alamofire

class VideosIndexController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var myCollectionViewVideos: UICollectionView!
    @IBOutlet weak var myCollectionViewVideosFlowLayout: UICollectionViewFlowLayout!
    
    var current_subject: Subject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionViewVideos.delegate = self
        myCollectionViewVideos.dataSource = self
        setCollectionViewLayoutStyle()
        self.title = current_subject.title
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return current_subject.videos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let thisVideo = current_subject.videos[indexPath.row]
        let cell = myCollectionViewVideos.dequeueReusableCellWithReuseIdentifier("VideoCellId", forIndexPath: indexPath) as! VideoCell
        cell.imageVideo.image = nil
        cell.imageVideo.image = thisVideo.returnBadgeImage()
        cell.labelVideoTitle.text = thisVideo.title
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Phone :
            cell.labelVideoTitle.font = iPhoneFontTiny
        case .Pad :
            cell.labelVideoTitle.font = iPadFontTiny
        default: cell.labelVideoTitle.font = iPhoneFontTiny
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell: VideoCell = myCollectionViewVideos.cellForItemAtIndexPath(indexPath) as! VideoCell
        performSegueWithIdentifier("VideosToVideoSegue", sender: cell)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "VideosToVideoSegue" {
            let indexPath = myCollectionViewVideos.indexPathForCell(sender as! VideoCell)
            let vc = segue.destinationViewController as! VideoShowController
            vc.currentVideo = current_subject.videos[indexPath!.row]
        }
    }
    
    func setCollectionViewLayoutStyle(){
        let width = CGRectGetWidth(view.bounds) / 4
        let spacingBetweenCells: CGFloat = 10
        let cellWidth: CGFloat = width - (spacingBetweenCells * 2)
        print("Cell width: \(cellWidth). width: \(width). Total width: \(CGRectGetWidth(myCollectionViewVideos!.frame))")
        myCollectionViewVideosFlowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
    }
    
    
    
}
