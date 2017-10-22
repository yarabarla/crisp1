//
//  Nib.swift
//  Crisp
//
//  Created by Jayesh Kaushik on 10/22/17.
//  Copyright © 2017 Crisp. All rights reserved.
//

import Foundation
import UIKit
class NibView : UIView {
    
    
    class func initNib() -> NibView {
        return UINib(nibName: "CameraViewController", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! NibView
    }
}
