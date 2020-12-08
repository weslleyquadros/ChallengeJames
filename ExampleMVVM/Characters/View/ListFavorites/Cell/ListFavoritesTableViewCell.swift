//
//  ListFavoritesTableViewCell.swift
//  ExampleMVVM
//
//  Created by Weslley Quadros on 01/12/20.
//  Copyright © 2020 Weslley Quadros. All rights reserved.
//

import UIKit

class ListFavoritesTableViewCell: UITableViewCell {
    static let identifier = "ListFavoritesTableViewCell"
    weak var delegate: ListTableViewCellDelegate?

    //MARK: - UI
    private let baseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let avatar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
        
    }()
    
    let favoriteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("favoriteLabel", comment: "")
        label.textColor = .white
        label.font = UIFont(name:"gotham-book", size: 8)
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name:"gotham-bold", size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private let locationTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.text = NSLocalizedString("labelLocationFav", comment: "")
        label.font = UIFont(name:"gotham-book", size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name:"gotham-medium", size: 11)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupUI()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(baseView)
        baseView.addSubview(avatar)
        baseView.addSubview(favoriteLabel)
        baseView.addSubview(nameLabel)
        baseView.addSubview(locationTitleLabel)
        baseView.addSubview(locationLabel)
        
        baseView.anchor(
            top: (self.topAnchor, 0),
            left: (self.leftAnchor, 22),
            right: (self.rightAnchor, 22),
            bottom: (self.bottomAnchor, 10)
        )
        
        avatar.anchor(
            top: (baseView.topAnchor, 0),
            left: (baseView.leftAnchor, 0),
            right: (nameLabel.leftAnchor, 15),
            bottom: (baseView.bottomAnchor, 0),
            width: 120
        )
        
        nameLabel.anchor(
            top: (baseView.topAnchor, 10),
            left: (avatar.rightAnchor, 15),
            right: (baseView.rightAnchor, 10)
        )
        
        locationTitleLabel.anchor(
            top: (nameLabel.bottomAnchor, 5),
            left: (nameLabel.leftAnchor, 0),
            right: (nameLabel.rightAnchor, 0)
        )
        
        locationLabel.anchor(
            top: (locationTitleLabel.bottomAnchor, 2),
            left: (nameLabel.leftAnchor, 0),
            right: (nameLabel.rightAnchor, 0),
            bottom: (baseView.bottomAnchor, 10)
        )
        
        favoriteLabel.anchor(
            top: (baseView.topAnchor, 5),
            right: (baseView.rightAnchor, 5)
        )
    }
    
    func setupData(id: Int, name: String, location: String, image: String) {
        guard let url = URL(string: image) else {return}
        DispatchQueue.main.async {
            self.getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                DispatchQueue.main.async {
                    self.avatar.image = UIImage(data: data)
                }
            }
            self.nameLabel.text = name
            self.locationLabel.text = location
        }
        
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
