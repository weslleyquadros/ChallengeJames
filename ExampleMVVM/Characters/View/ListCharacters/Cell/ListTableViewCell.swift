//
//  ListTableViewCell.swift
//  ExampleMVVM
//
//  Created by Weslley Quadros on 28/11/20.
//  Copyright © 2020 Weslley Quadros. All rights reserved.
//

import UIKit

protocol ListTableViewCellDelegate: class {
    func buttonTapped(cell: ListTableViewCell)
}

class ListTableViewCell: UITableViewCell {
    static let identifier = "ListTableViewCell"
    var link = ListCharactersViewController()
    var index = IndexPath()
    weak var delegate: ListTableViewCellDelegate?
    
    public var indexId = 0
    
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
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "favorite.png"), for: .normal)
        button.tintColor = .white
        return button
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
        label.text =  NSLocalizedString("labelLocation", comment: "")
        label.font = UIFont(name:"gotham-book", size: 12)
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
        favoriteButton.addTarget(self, action: #selector(handleButton
            ), for: .touchUpInside)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(baseView)
        baseView.addSubview(avatar)
        baseView.addSubview(favoriteButton)
        baseView.addSubview(nameLabel)
        baseView.addSubview(locationTitleLabel)
        baseView.addSubview(locationLabel)
        
        /* Insert constraint without extension for example purposes */
        
        baseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        baseView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 22).isActive = true
        baseView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -22).isActive = true
        baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        avatar.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 0).isActive = true
        avatar.leftAnchor.constraint(equalTo: baseView.leftAnchor, constant: 0).isActive = true
        avatar.rightAnchor.constraint(equalTo: baseView.leftAnchor, constant: -15).isActive = true
        avatar.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: 0).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.centerYAnchor.constraint(equalTo: baseView.centerYAnchor, constant: 0).isActive = true
        favoriteButton.rightAnchor.constraint(equalTo: baseView.rightAnchor, constant: -10).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 10).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 15).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: favoriteButton.leftAnchor, constant: -5).isActive = true
        
        locationTitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        locationTitleLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0).isActive = true
        locationTitleLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 0).isActive = true
        
        locationLabel.topAnchor.constraint(equalTo: locationTitleLabel.bottomAnchor, constant: 2).isActive = true
        locationLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0).isActive = true
        locationLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 0).isActive = true
        locationLabel.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -10).isActive = true
    }
    
    func setupData(id: Int, name: String, location: String, image: String, favIcon: UIImage) {
        guard let url = URL(string: image) else {return}
        DispatchQueue.main.async {
            self.getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                DispatchQueue.main.async {
                    self.avatar.image = UIImage(data: data)
                }
            }
            self.indexId = id
            self.nameLabel.text = name
            self.locationLabel.text = location
            
            self.favoriteButton.setImage(favIcon, for: .normal)
        }
        
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    @objc func handleButton(sender: UIButton) {
        self.delegate?.buttonTapped(cell: self)
    }
}
