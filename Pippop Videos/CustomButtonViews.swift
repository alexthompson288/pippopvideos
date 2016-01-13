//
//  CustomButtonViews.swift
//  Pippop Videos
//
//  Created by Alex Thompson on 13/01/2016.
//  Copyright © 2016 Alex Thompson. All rights reserved.
//

import Foundation
import UIKit


class myCustomMenuButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 12.0
        
        
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Phone:
            
            titleLabel?.font = iPhoneFontTiny
        case .Pad:
            titleLabel?.font = iPadFontSmall
        default:
            print("Another device")
        }
        
        self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.backgroundColor = customColorOrange
    }
}