//
//  CompetitionsCollectionView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 30.10.2022.
//

import UIKit

protocol CompetitionsCollectionViewDelegate: AnyObject{
    func pressCompetition(index: Int)
}

class CompetitionsCollectionView: UIView {
    
    var competitions = [Competition]()
    
    weak var delegate: CompetitionsCollectionViewDelegate?
    
    lazy var competitionsCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CompetitionCollectionViewCell.self, forCellWithReuseIdentifier: CompetitionCollectionViewCell.identifire)
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.competitions = CompetitionsViewController.competitions
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(competitionsCollectionView)
        
        NSLayoutConstraint.activate([
            competitionsCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            competitionsCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            competitionsCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            competitionsCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
  
}

extension CompetitionsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset = 16
        let width = (Int(self.bounds.width) - inset*2)/1
        let height = (Int(self.bounds.height) - inset*6)/5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pressCompetition(index: indexPath.row)
    }
}

extension CompetitionsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CompetitionsViewController.competitions.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompetitionCollectionViewCell.identifire, for: indexPath) as! CompetitionCollectionViewCell

        cell.nameLabel.text = CompetitionsViewController.competitions[indexPath.row].title
        cell.dateLabel.text = dateFormater(CompetitionsViewController.competitions[indexPath.row].date)

        switch indexPath.row % 2 {
        case 0: cell.contentView.backgroundColor = .anyColor
        case 1: cell.contentView.backgroundColor = .anyColor1
        default:
            cell.backgroundColor = .anyColor
        }

        return cell
    }
}
