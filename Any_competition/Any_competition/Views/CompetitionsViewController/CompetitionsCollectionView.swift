//
//  CompetitionsCollectionView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 30.10.2022.
//

import UIKit
import SnapKit

protocol CompetitionsCollectionViewDelegate: AnyObject{
    func pressCompetition(index: Int)
}

class CompetitionsCollectionView: UIView {
    
    var competitions = [Competition]() {
        didSet{
            competitionsCollectionView.reloadData()
        }
    }
    
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
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(competitionsCollectionView)
        
        competitionsCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }
    
    func reloadCollection() {
        self.competitionsCollectionView.reloadData()
    }
  
}

extension CompetitionsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let inset = 16
        
        var size = CGSize(width: 0, height: 0)
        
        if indexPath.row < competitions.count {
            let width = (Int(self.bounds.width) - inset*2)/1
            let height = (Int(self.bounds.height) - inset*6)/5
            return CGSize(width: width, height: height)
        } else {
            let width = (Int(self.bounds.width) - inset*2)/1
            let height = 76
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row < competitions.count {
            delegate?.pressCompetition(index: indexPath.row)
        } else {
        }
        
        
    }
}

extension CompetitionsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        competitions.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompetitionCollectionViewCell.identifire, for: indexPath) as! CompetitionCollectionViewCell
        cell.backgroundColor = .backgroundColor
        if indexPath.row < competitions.count {
            cell.nameLabel.text = competitions[indexPath.row].title
            cell.dateLabel.text = dateFormater(competitions[indexPath.row].date)

            if ((indexPath.row % 2) != 0) {
                cell.contentView.backgroundColor = .anyGreenColor
            } else {
                cell.contentView.backgroundColor = .anyPurpleColor
            }
        }
        return cell
    }
}
