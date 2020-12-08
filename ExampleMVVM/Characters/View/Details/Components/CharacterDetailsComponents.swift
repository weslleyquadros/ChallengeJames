//
//  CharacterDetailsComponents.swift
//  ExampleMVVM
//
//  Created by Weslley Quadros on 03/12/20.
//  Copyright © 2020 Weslley Quadros. All rights reserved.
//

import UIKit

class CharacterDetailsComponents {
    //Background
    var backgroundUserProfile : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    var blurBackground : UIVisualEffectView = {
        var darkBlur = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let element = UIVisualEffectView(effect: darkBlur)
        element.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        element.alpha = 0.8
        return element
    }()
    
    var toblur : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var userView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 75
        imageView.layer.borderWidth = 6
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.background_circleView.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var imageUserButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 75
        return button
    }()
    
    var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = -1
        label.font = UIFont(name:"gotham-bold", size: 25)
        label.textColor = UIColor.text_titleLabel
        
        return label
    }()
    
    var cardView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.background_card
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 20.0
        return view
    }()
    
    var statusTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name:"gotham-book", size: 14)
        label.text = NSLocalizedString("statusTitleLabel", comment: "")
        label.textColor = UIColor.text_label
        label.textAlignment = .left
        return label
    }()
    
    var statusIcon : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "active")
        return imageView
    }()
    
    var statusValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name:"gotham-medium", size: 14)
        label.textColor = UIColor.text_label
        label.textAlignment = .right
        return label
    }()
    
    var lineDivider1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.background_tableLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var locationTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name:"gotham-book", size: 14)
        label.text = NSLocalizedString("labelDetaisLocation", comment: "")
        label.textColor = UIColor.text_label
        label.textAlignment = .left
        return label
    }()
    
    
    var locationValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name:"gotham-medium", size: 14)
        label.textColor = UIColor.text_label
        label.textAlignment = .right
        return label
    }()
    
    var lineDivider2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.background_tableLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var episodeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name:"gotham-book", size: 14)
        label.text = NSLocalizedString("labelDatailsEpisode", comment: "")
        label.textColor = UIColor.text_label
        label.textAlignment = .left
        return label
    }()
    
    var episodeValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name:"gotham-medium", size: 14)
        label.textColor = UIColor.text_label
        label.textAlignment = .right
        return label
    }()
    
    var buttonSeeMore: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("buttonSeeMore", comment: ""), for: .normal)
        button.setTitleColor(UIColor.text_titleLabel, for: .normal)
        button.titleLabel?.font = UIFont(name:"gotham-book", size: 12)
        button.layer.borderColor = UIColor.text_titleLabel.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
}
