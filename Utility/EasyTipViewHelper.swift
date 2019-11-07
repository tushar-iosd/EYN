//
//  EasyTipViewHelper.swift
//  Appecules
//
//  Created by admin on 30/08/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import EasyTipView

class EasyTipViewHelper : NSObject,EasyTipViewDelegate {
    var globalPreferences = EasyTipView.globalPreferences
    var tipView : EasyTipView?
    func easyTipViewDidDismiss(_ tipView: EasyTipView) {
        print("Dismissed")
    }
    
    
    public func setPreferences(){
        globalPreferences = EasyTipView.globalPreferences
        globalPreferences.drawing.font = UIFont(name: "Futura-Medium", size: 13)!
        globalPreferences.drawing.foregroundColor = UIColor.darkGray
        globalPreferences.drawing.backgroundColor = UIColor(hue:0.46, saturation:0.99, brightness:0.6, alpha:1)
        globalPreferences.drawing.arrowPosition = EasyTipView.ArrowPosition.bottom
        globalPreferences.animating.dismissTransform = CGAffineTransform(translationX: 0, y: -15)
        globalPreferences.animating.showInitialTransform = CGAffineTransform(translationX: 0, y: -15)
        tipView = EasyTipView(text: "Some textsadasfadSFMLAMSDLFJOADJSFOJADSJFJADSFJADSJFASDJLJFJKLASDNJKFKADSFJKLADSKLFNADSFJKLAJKSDHFKADHSFKHADJKSFHOADSHFHASFADSHFJKLAHSDJKLFHAJKLSDHFKLJDHSFJKLHASDJKLFHAJSDFJKLAHSDJKFHJKLADSHFJKLAHSDKLJFHNASJKLDFJKLADSHFKJAHSDFJKLHASDKHFJKLASDHFJKHASDKHFJKLASEHIO", preferences: globalPreferences)
    }
    
}
