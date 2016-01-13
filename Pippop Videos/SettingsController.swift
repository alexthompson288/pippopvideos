//
//  SettingsController.swift
//  lettersounds
//
//  Created by Alex Thompson on 12/01/2016.
//  Copyright © 2016 Alex Thompson. All rights reserved.
//

import Foundation
import UIKit

class SettingsController: UIViewController {
        
    override func viewDidLoad() {

    }
    
    @IBAction func ActionReset(sender: AnyObject) {
        if #available(iOS 8.0, *) {
            print("Clearing defaults with new IOS")
            let alertController = UIAlertController(title: "Are you sure", message: "Are you sure you want to delete all progress?", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action:UIAlertAction!) in
                print("you have pressed the Cancel button");
            }
            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
                print("you have pressed OK button");
                
                let searchPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
                let fileManager = NSFileManager.defaultManager()
                
                let allContents = self.contentsOfDirectoryAtPath(searchPath)
                if let theseContents = allContents {
                    for path in theseContents {
                        if (fileManager.fileExistsAtPath(path)){
                            
                            // Delete 'hello.swift' file
                            
                            do {
                                try fileManager.removeItemAtPath(path)
                                print("Deleted at \(path)")
                                
                                
                            }
                            catch let error as NSError {
                                print("Ooops! Something went wrong: \(error)")
                            }
                            
                        }
                    }
                    
                    
                }
                
                
                
                print("you have pressed OK button");
                
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true, completion:nil)
        }
    }
    
    func contentsOfDirectoryAtPath(path: String) -> [String]? {
        guard let paths = try? NSFileManager.defaultManager().contentsOfDirectoryAtPath(path) else { return nil}
        return paths.map { aContent in (path as NSString).stringByAppendingPathComponent(aContent)}
    }
    
    
    
    
}