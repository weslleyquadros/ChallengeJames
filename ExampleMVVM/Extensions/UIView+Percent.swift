//
//  UIView+Percent.swift
//  ChallengeJames
//
//  Created by Weslley Quadros on 30/11/20.
//  Copyright © 2020 Weslley Quadros. All rights reserved.
//

import UIKit

extension UIView {
    
    func percentOfHeight( percent : CGFloat) -> CGFloat {
        return ((frame.height * percent) / 100)
    }
    
    func percentOfWidth( percent : CGFloat) -> CGFloat {
        return ((frame.width * percent) / 100)
    }
    
}
