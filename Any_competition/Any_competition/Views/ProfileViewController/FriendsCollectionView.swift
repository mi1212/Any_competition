//
//  FriendsCollectionView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 13.11.2022.
//

import UIKit
import SnapKit

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
    
    let label = AnyCompUILabel(title: "Друзья", fontSize: .medium)
    
    lazy var labelFriendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Друзья...", for: .normal)
        button.setTitleColor(.black, for: .normal)
//        button.setImage(UIImage(named: "plus"), for: .normal)
        return button
    }()
    
    lazy var followersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.isScrollEnabled = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(FriendCollectionViewCell.self, forCellWithReuseIdentifier: FriendCollectionViewCell.identifire)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    lazy var addFriendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewsWithoutButton() {
        self.addSubview(labelFriendButton)
        labelFriendButton.addTarget(self, action: #selector(tapFriendButton), for: .touchUpInside)
        self.addSubview(followersCollectionView)
 
        let inset = CGFloat(16)
//
//        label.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.leading.equalToSuperview().inset(inset)
//        }
        
        labelFriendButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(inset)
            make.height.equalTo(16)
        }
        
        followersCollectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(labelFriendButton.snp.bottom).offset(inset)
        }
    }
    
    private func setupButton() {
        self.addSubview(addFriendButton)
        addFriendButton.addTarget(self, action: #selector(tapAddFriendButton), for: .touchUpInside)
        
        addFriendButton.snp.makeConstraints { make in
            make.centerY.equalTo(labelFriendButton)
            make.width.height.equalTo(24)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setupViews() {
            setupViewsWithoutButton()
            setupButton()
    }
    
    @objc func tapAddFriendButton() {
        animationTapButton(addFriendButton)
        delegate?.tapAddFriendButton()
    }
    
    @objc func tapFriendButton() {
        animationTapButton(labelFriendButton)
        print("tapFriendButton")
    }
}

extension FriendsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        user?.friends.count ?? 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.identifire, for: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendCollectionViewCell.identifire, for: indexPath) as! FriendCollectionViewCell
        cell.backgroundColor = .white
//        switch indexPath.row % 2 {
//        case 0: cell.contentView.backgroundColor = .anyGreenColor
//        case 1: cell.contentView.backgroundColor = .anyDarckColor
//        default:
//            cell.backgroundColor = .anyGreenColor
//        }
        
        return cell
    }
 
}

extension FriendsCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset = 8
        let width = (Int(self.bounds.width) - inset*4)/1
        let height = (Int(self.bounds.height) - inset*3-36)/4
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
}

