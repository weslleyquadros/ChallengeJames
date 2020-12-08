//
//  CharacterDetailsListEpisodeCell.swift
//  ExampleMVVM
//
//  Created by Weslley Quadros on 02/12/20.
//  Copyright © 2020 Weslley Quadros. All rights reserved.
//

import UIKit

class CharacterDetailsHeaderListEpisodeCell: UITableViewCell {
    static let identifier = "CharacterDetailsHeaderListEpisodeCell"
    var episodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name:"gotham-bold", size: 15)
        label.text = NSLocalizedString("cellEpisodeCode", comment: "")
        label.textColor = UIColor.text_titleLabel
        label.textAlignment = .left
        return label
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name:"gotham-bold", size: 15)
        label.text = NSLocalizedString("cellEpisodeName", comment: "")
        label.textColor = UIColor.text_titleLabel
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .background_card
        setupUI()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        

        addSubview(episodeLabel)
        addSubview(nameLabel)
        
        episodeLabel.anchor(
            centerY: (self.centerYAnchor, 0),
            left: (self.leftAnchor, 25),
            right: (nameLabel.leftAnchor, 8)
        )
        
        nameLabel.anchor(
            centerY: (self.centerYAnchor, 0),
            left: (episodeLabel.rightAnchor, 8),
            right: (self.rightAnchor, 25)
        )
    }
}
