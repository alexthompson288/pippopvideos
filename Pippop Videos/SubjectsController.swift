//
//  ViewController.swift
//  Pippop Videos
//
//  Created by Alex Thompson on 13/01/2016.
//  Copyright © 2016 Alex Thompson. All rights reserved.
//

import UIKit
import AVFoundation
import Parse
import Alamofire

class SubjectsController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var myCollectionViewSubjects: UICollectionView!
    
    @IBOutlet weak var myCollectionViewSubjectsFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utility.loadData()
        myCollectionViewSubjects.delegate = self
        myCollectionViewSubjects.dataSource = self
        setCollectionViewLayoutStyle()
        let imgView = UIImageView(image: UIImage(named: "icon_logo"))
        imgView.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        imgView.contentMode = .ScaleAspectFit
        self.navigationItem.titleView = imgView
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return video_data.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let subject = video_data[indexPath.row]
        let cell = myCollectionViewSubjects.dequeueReusableCellWithReuseIdentifier("SubjectCellId", forIndexPath: indexPath) as! SubjectCell
        cell.imageSubject.image = nil
        cell.imageSubject.image = UIImage(named: subject.imageUrl)
        cell.labelSubject.text = subject.title
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Phone :
            cell.labelSubject.font = iPhoneFontMedium
        case .Pad :
            cell.labelSubject.font = iPadFontMedium
        default: cell.labelSubject.font = iPhoneFontMedium
        }

        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell: SubjectCell = myCollectionViewSubjects.cellForItemAtIndexPath(indexPath) as! SubjectCell

        performSegueWithIdentifier("SubjectsToVideosSegue", sender: cell)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SubjectsToVideosSegue" {
            let indexPath = myCollectionViewSubjects.indexPathForCell(sender as! SubjectCell)
            var subject = video_data[indexPath!.row]
            let vc = segue.destinationViewController as! VideosIndexController
            let dimensions = [
                "subject" : "\(subject.title)"
            ]
            PFAnalytics.trackEvent("subject_chosen", dimensions: dimensions)
            vc.current_subject = video_data[indexPath!.row]
        }
    }
    
    func setCollectionViewLayoutStyle(){
        let width = CGRectGetWidth(view.bounds) / 3
        let spacingBetweenCells: CGFloat = 10
        let cellWidth: CGFloat = width - (spacingBetweenCells * 2)
        let cellHeight: CGFloat = (self.view.bounds.height / 2) - (self.view.bounds.height * 0.1)
        print("Cell width: \(cellWidth). width: \(width). Total width: \(CGRectGetWidth(myCollectionViewSubjects!.frame))")
        myCollectionViewSubjectsFlowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
    }


}

