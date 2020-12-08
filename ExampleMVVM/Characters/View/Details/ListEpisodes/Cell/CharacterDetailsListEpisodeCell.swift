//
//  CharacterDetailsCell.swift
//  ExampleMVVM
//
//  Created by Weslley Quadros on 02/12/20.
//  Copyright © 2020 Weslley Quadros. All rights reserved.
//

import UIKit

class CharacterDetailsListEpisodeCell: UITableViewCell {
    static let identifier = "CharacterDetailsListEpisodeCell"
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name:"gotham-book", size: 14)
        label.textColor = UIColor.text_label
        label.textAlignment = .left
        return label
    }()
    
    var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name:"gotham-medium", size: 14)
        label.textColor = UIColor.text_label
        label.textAlignment = .right
        return label
    }()
    
    var lineDivider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.background_tableLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        valueLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        addSubview(titleLabel)
        addSubview(valueLabel)
        addSubview(lineDivider)
        
        titleLabel.anchor(
            centerY: (valueLabel.centerYAnchor, 0),
            left: (self.leftAnchor, 25),
            right: (valueLabel.leftAnchor, 8)
        )
        
        valueLabel.anchor(
            centerY: (self.centerYAnchor, 0),
            left: (titleLabel.rightAnchor, 8),
            right: (self.rightAnchor, 25)
        )
        
        lineDivider.anchor(
            left: (self.leftAnchor, 25),
            right: (self.rightAnchor, 25),
            bottom: (self.bottomAnchor, 0),
            height: 1
        )
    }
    
    func setupData(episode: String, name: String){
        self.titleLabel.text = episode
        self.valueLabel.text = name
        self.tag = tag
    }
}
