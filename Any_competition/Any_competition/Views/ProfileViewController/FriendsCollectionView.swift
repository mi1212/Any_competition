//
//  FriendsCollectionView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 13.11.2022.
//

import UIKit

protocol FriendsCollectionViewDelegate: AnyObject {
    func tapAddFriendButton()
}

class FriendsCollectionView: UIView {
    
    let userDefaults = UserDefaults.standard
    
    weak var delegate: FriendsCollectionViewDelegate?
    
    // MARK: - UIViews
    
    var user: User? {
        didSet {
//            self.layoutIfNeeded()
        }
    }
    
    let label = AnyCompUILabel(title: "Друзья: ", fontSize: .medium)
    
    lazy var followersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collection.backgroundColor = .clear
        
        collection.delegate = self
        collection.dataSource = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.identifire)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    lazy var addFriendButton = AnyCompClearUIButton(title: "+")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .brown
        setupViews()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewsWithoutButton() {
        self.addSubview(label)
        self.addSubview(followersCollectionView)
        
        
        
        let inset = CGFloat(8)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            followersCollectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: inset),
            followersCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            followersCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            followersCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset),
        ])
    }
    
    private func setupButton() {
        self.addSubview(addFriendButton)
        
        addFriendButton.backgroundColor = .anyColor
        addFriendButton.addTarget(self, action: #selector(tapAddFriendButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addFriendButton.topAnchor.constraint(equalTo: label.topAnchor),
            addFriendButton.bottomAnchor.constraint(equalTo: label.bottomAnchor),
            addFriendButton.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func setupViews() {
//        if user?.id == userDefaults.object(forKey: "uid") as! String {
            setupViewsWithoutButton()
            setupButton()
//        } else {
//            setupViewsWithoutButton()
//        }
        
    }
    
    private func setupMainView() {
        self.backgroundColor = .anyDarckColor
//        self.backgroundColor = .clear
        self.layer.cornerRadius = 24
        self.clipsToBounds = true
    }
    
    @objc func tapAddFriendButton() {
        animationTapButton(addFriendButton)
        delegate?.tapAddFriendButton()
    }
}

extension FriendsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        user?.friends.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.identifire, for: indexPath)
        
        switch indexPath.row % 2 {
        case 0: cell.contentView.backgroundColor = .anyColor
        case 1: cell.contentView.backgroundColor = .anyDarckColor
        default:
            cell.backgroundColor = .anyColor
        }
        
        return cell
    }
 
}

extension FriendsCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset = 8
        let width = (Int(self.bounds.width) - inset*5)/4
        let height = (Int(self.bounds.height) - inset*2)/1
        return CGSize(width: width, height: height)
    }
}

