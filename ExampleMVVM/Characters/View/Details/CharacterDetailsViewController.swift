//
//  CharacterDetailsViewController.swift
//  ExampleMVVM
//
//  Created by Weslley Quadros on 30/11/20.
//  Copyright © 2020 Weslley Quadros. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    var component = CharacterDetailsComponents()
    var viewModel = CharacterDetailsViewModel()
    var loadingIndicator = UIActivityIndicatorView()
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    var contentView = UIView()
    var listEpisodes: ListEpisodes!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavidation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getFirstEpisode()
        self.view.backgroundColor = UIColor.background_card
        self.setupView()
        self.setupConstraints()
        self.addLoading()
    }
    
    private func setupNavidation() {
        navigationController?.navigationBar.accessibilityIdentifier = "DetailsNavigationBar"
        navigationItem.backBarButtonItem?.accessibilityIdentifier = "DetailsButtonBack"
        title = NSLocalizedString("titleDetails", comment: "")
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func addLoading() {
        loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        self.component.cardView.addSubview(loadingIndicator)
        loadingIndicator.anchor(
            centerY: (component.buttonSeeMore.centerYAnchor, 0),
            left: (component.buttonSeeMore.rightAnchor, 10)
        )
    }
    
    private func getFirstEpisode() {
        viewModel.fetchEpisode { [weak self] episode in
            guard let self = self else{return}
            switch episode {
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
            case .success(let data):
                DispatchQueue.main.async {
                    self.component.episodeValueLabel.text = "\(data.name) - \(data.episode)"
                    self.viewModel.episode = data
                    self.view.layoutIfNeeded()
                }
            }
            
        }
    }
    
    private func getListEpisodes() {
        self.viewModel.listEpisodes.removeAll()
        
        self.viewModel.fetchListEpisodes { [weak self] episodes in
            guard let self = self else{return}
            switch episodes {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            case .success(let data):
                DispatchQueue.main.async {
                    self.viewModel.listEpisodes.append(data)
                    self.view.layoutIfNeeded()
                    self.loadingIndicator.stopAnimating()
                }
            }
            
        }
    }
    
    private func setupView() {
        guard let url = URL(string: viewModel.character?.image ?? "") else {return}
        DispatchQueue.main.async {
            self.getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                DispatchQueue.main.async {
                    self.component.backgroundUserProfile.image = UIImage(data: data) ?? UIImage()
                    self.component.userView.image = UIImage(data: data) ?? UIImage()
                }
            }
        }
        
        component.buttonSeeMore.accessibilityIdentifier = "ButtonSeeMore"
        
        component.backgroundUserProfile.frame = (view.bounds)
        component.blurBackground.frame = (view.bounds)
        
        component.userNameLabel.text = viewModel.character?.name
        
        guard let status = viewModel.character?.status.formatToLabel, let species = viewModel.character?.species.formatToLabel else {return}
        component.statusValueLabel.text = "\(status) - \(species)"
        
        var iconColor = UIColor()
        switch viewModel.character?.status {
        case .alive:
            iconColor = .green
        case .dead:
            iconColor = .darkGray
        default:
            iconColor = .red
        }
        
        component.statusIcon.tintColor = iconColor
        
        component.locationValueLabel.text = viewModel.character?.location.name
        
        if viewModel.character?.episode.count == 1 {
            component.buttonSeeMore.isHidden = true
        } else {
            component.buttonSeeMore.isHidden = false
        }
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(component.backgroundUserProfile)
        contentView.addSubview(component.toblur)
        
        component.toblur.addSubview(component.blurBackground)
        
        contentView.addSubview(component.cardView)
        
        contentView.addSubview(component.userView)
        
        contentView.addSubview(component.imageUserButton)
        contentView.addSubview(component.userNameLabel)
        
        component.cardView.addSubview(component.statusTitleLabel)
        component.cardView.addSubview(component.statusIcon)
        component.cardView.addSubview(component.statusValueLabel)
        component.cardView.addSubview(component.lineDivider1)
        component.cardView.addSubview(component.locationTitleLabel)
        component.cardView.addSubview(component.locationValueLabel)
        component.cardView.addSubview(component.lineDivider2)
        component.cardView.addSubview(component.episodeTitleLabel)
        component.cardView.addSubview(component.episodeValueLabel)
        component.cardView.addSubview(component.buttonSeeMore)
    }
    
    func setupConstraints(){
        scrollView.delegate = self
        scrollView.anchor(
            top: (view.topAnchor, 0),
            left: (view.leftAnchor, 0),
            right: (view.rightAnchor, 0),
            bottom: (view.bottomAnchor, 0)
        )
        
        contentView.anchor(
            top: (scrollView.topAnchor, 0),
            left: (view.leftAnchor, 0),
            right: (view.rightAnchor, 0),
            bottom: (scrollView.bottomAnchor, 0 )
        )
        
        component.backgroundUserProfile.anchor(
            top: (contentView.topAnchor, 0),
            left: (contentView.leftAnchor, 0),
            right: (contentView.rightAnchor, 0),
            bottom: (component.userView.centerYAnchor, 0),
            height: self.view.percentOfHeight(percent: 45)
        )
        
        component.blurBackground.anchor(
            top: (contentView.topAnchor, 0),
            left: (contentView.leftAnchor, 0),
            right: (contentView.rightAnchor, 0),
            height: self.view.percentOfHeight(percent: 55)
        )
        
        component.toblur.anchor(
            top: (contentView.topAnchor, 0),
            left: (contentView.leftAnchor, 0),
            right: (contentView.rightAnchor, 0),
            height: self.view.percentOfHeight(percent: 45)
        )
        
        component.userView.anchor(
            centerX: (contentView.centerXAnchor, 0),
            width: 150,
            height: 150
        )
        
        component.cardView.anchor(
            top: (component.userView.centerYAnchor, 0),
            left: (contentView.leftAnchor, 0),
            right: (contentView.rightAnchor, 0),
            bottom: (contentView.bottomAnchor, 0),
            height: 400
        )
        
        
        component.imageUserButton.anchor(
            centerX: (contentView.centerXAnchor, 0),
            top: (contentView.topAnchor, self.view.percentOfHeight(percent: 8)),
            width: self.view.percentOfWidth(percent: 40),
            height: self.view.percentOfHeight(percent: 40)
        )
        
        component.userNameLabel.anchor(
            centerX: (contentView.centerXAnchor, 0),
            top: (component.userView.bottomAnchor, self.view.percentOfHeight(percent: 1))
        )
        
        component.statusTitleLabel.anchor(
            top: (component.userNameLabel.bottomAnchor, 30),
            left: (component.cardView.leftAnchor, 24)
        )
        
        component.statusIcon.anchor(
            centerY: (component.statusTitleLabel.centerYAnchor, 0),
            right: (component.statusValueLabel.leftAnchor, 5),
            width: 10,
            height: 10
        )
        
        component.statusValueLabel.anchor(
            centerY: (component.statusTitleLabel.centerYAnchor, 0),
            left: (component.statusIcon.rightAnchor, 5),
            right: (component.cardView.rightAnchor, 24)
        )
        
        component.lineDivider1.anchor(
            top: (component.statusTitleLabel.bottomAnchor, 10),
            left: (component.cardView.leftAnchor, 24),
            right: (component.cardView.rightAnchor, 24),
            height: 1
        )
        
        component.locationTitleLabel.anchor(
            centerY: (component.locationValueLabel.centerYAnchor, 0),
            left: (component.cardView.leftAnchor, 24),
            right: (component.locationValueLabel.leftAnchor, 8)
        )
        component.locationTitleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        component.locationValueLabel.anchor(
            top: (component.lineDivider1.bottomAnchor, 10),
            left: (component.locationTitleLabel.rightAnchor, 8),
            right: (component.cardView.rightAnchor, 24)
        )
        component.locationValueLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        component.lineDivider2.anchor(
            top: (component.locationValueLabel.bottomAnchor, 10),
            left: (component.cardView.leftAnchor, 24),
            right: (component.cardView.rightAnchor, 24),
            height: 1
        )
        
        component.episodeTitleLabel.anchor(
            centerY: (component.episodeValueLabel.centerYAnchor, 0),
            left: (component.cardView.leftAnchor, 24),
            right: (component.episodeValueLabel.leftAnchor, 8)
        )
        component.episodeTitleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        component.episodeValueLabel.anchor(
            top: (component.lineDivider2.bottomAnchor, 10),
            left: (component.episodeTitleLabel.rightAnchor, 8),
            right: (component.cardView.rightAnchor, 24)
        )
        
        component.episodeValueLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        component.buttonSeeMore.anchor(
            centerX: (component.cardView.centerXAnchor, 0),
            top: (component.episodeValueLabel.bottomAnchor, 25),
            width: 100
        )
        
        component.buttonSeeMore.addTarget(self, action: #selector(seeMoreEpisodes), for: .touchUpInside)
    }
    
    @objc func seeMoreEpisodes(_ sender: UIButton) {
        let vc = CharactersDetailsListEpisodesViewController()
        self.loadingIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.getListEpisodes()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                vc.viewModel.listEpisodes = self.viewModel.listEpisodes
                 let navVC = UINavigationController(rootViewController: vc)
                self.present(navVC, animated: true, completion: nil)
            }
        }
    }
}

extension CharacterDetailsViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0  {
            scrollView.contentOffset.y = 0
        }
    }
}
