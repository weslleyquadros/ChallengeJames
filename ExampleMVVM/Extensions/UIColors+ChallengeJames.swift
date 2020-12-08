//
//  UIColors+ChallengeJames.swift
//  ChallengeJames
//
//  Created by Weslley Quadros on 30/11/20.
//  Copyright © 2020 Weslley Quadros. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    // MARK: - background_card
    /**
     Light: #F1F0F0
     Dark: #16191F
     */
    class var background_card: UIColor {
        return UIColor.init(named: "background_card") ?? UIColor.white
    }

    // MARK: - background_tableLine
    /**
     Light: #B6B6B7
     Dark: #52555A
     */
    class var background_tableLine: UIColor {
        return UIColor.init(named: "background_tableLine") ?? UIColor.white
    }
    
    // MARK: - text_label
    /**
     Light: #787878
     Dark: #D3D3D3
     */
    class var text_label: UIColor {
        return UIColor.init(named: "text_label") ?? UIColor.white
    }
    
    // MARK: - text_titleButton
    /**
     Light: #FFFFFF
     Dark: #FFFFFF
     */
    class var text_titleButton: UIColor {
        return UIColor.init(named: "text_titleButton") ?? UIColor.white
    }
    
    // MARK: - text_titleLabel
    /**
     Light: #F1F0F0
     Dark: #FFFFFF
     */
    class var text_titleLabel: UIColor {
        return UIColor.init(named: "text_titleLabel") ?? UIColor.white
    }
    
    //MARK: - background_tableLineGray
    /**
    Light: #E8E8E8
    Dark: #333539
    */
    class var background_tableLineGray: UIColor {
        return UIColor.init(named: "background_tableLineGray") ?? UIColor.white
    }
    
    //MARK: - background_circleView
    /**
       Light: #FFFFFF
       Dark: #424446
    */
    class var background_circleView: UIColor {
           return UIColor.init(named: "background_circleView") ?? UIColor.white
       }
}
