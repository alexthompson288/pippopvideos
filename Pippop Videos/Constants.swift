//
//  Constants.swift
//  Pippop Videos
//
//  Created by Alex Thompson on 13/01/2016.
//  Copyright © 2016 Alex Thompson. All rights reserved.
//

import Foundation
import UIKit

var video_data = [Subject]()

let Homedir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]

var jsonFileName = "videos"
let customColorRed = UIColor.init(red: 246, green: 135, blue: 107)
let customColorOrange = UIColor.init(red: 254, green: 197, blue: 125)
let customColorGreen = UIColor.init(red: 76, green: 195, blue: 24)

var iPadFontTiny = UIFont(name: "Arial Rounded MT Bold", size: 24)
var iPadFontSmall = UIFont(name: "Arial Rounded MT Bold", size: 22)
var iPadFont = UIFont(name: "Arial Rounded MT Bold", size: 56)
var iPadFontMedium = UIFont(name: "Arial Rounded MT Bold", size: 36)
var iPadFontPipRegular = UIFont(name: "pipfontregular", size: 56)
var iPadFontLarge = UIFont(name: "Arial Rounded MT Bold", size: 90)
var iPadFontXXL = UIFont(name: "pipfontregular", size: 300)
var iPadFontXXXL = UIFont(name: "pipfontregular", size: 350)

var iPhoneFontTiny = UIFont(name: "Arial Rounded MT Bold", size: 10)
var iPhoneFont = UIFont(name: "Arial Rounded MT Bold", size: 22)
var iPhoneFontMedium = UIFont(name: "Arial Rounded MT Bold", size: 22)
var iPhoneFontMediumSmall = UIFont(name: "Arial Rounded MT Bold", size: 16)
var iPhoneFontPipRegular = UIFont(name: "pipfontregular", size: 22)
var iPhoneFontXXL = UIFont(name: "pipfontregular", size: 150)

var MyBackgrounds = ["bg_01", "bg_02", "bg_03", "bg_04"]


var pingSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("plop", ofType: "mp3")!)
var audioReady = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ready", ofType: "mp3")!)
var audioSteady = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("steady", ofType: "mp3")!)
var audioGo = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("go", ofType: "mp3")!)

func delay(seconds seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}
