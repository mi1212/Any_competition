//
//  CompetitionTableView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 26.09.2022.
//

import UIKit

class CompetitionTableView: UIView {

    private lazy var tableCollectionView: UICollectionView = {
        let table = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .black
        table.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var playersNamesTableView: UICollectionView = {
        let table = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        table.backgroundColor = .cyan
        table.delegate = self
        table.dataSource = self
        table.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var playersScoreTableView: UICollectionView = {
        let table = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        table.backgroundColor = .green
        table.delegate = self
        table.dataSource = self
        table.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(tableCollectionView)
        self.addSubview(playersNamesTableView)
        self.addSubview(playersScoreTableView)
        
        NSLayoutConstraint.activate([
            tableCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            tableCollectionView.leadingAnchor.constraint(equalTo: playersNamesTableView.trailingAnchor),
            tableCollectionView.trailingAnchor.constraint(equalTo: playersScoreTableView.leadingAnchor),
            tableCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            playersNamesTableView.topAnchor.constraint(equalTo: self.topAnchor),
            playersNamesTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            playersNamesTableView.trailingAnchor.constraint(equalTo: tableCollectionView.leadingAnchor),
            playersNamesTableView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/6),
            playersNamesTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])

        NSLayoutConstraint.activate([
            playersScoreTableView.topAnchor.constraint(equalTo: self.topAnchor),
            playersScoreTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            playersScoreTableView.leadingAnchor.constraint(equalTo: tableCollectionView.trailingAnchor),
            playersScoreTableView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/6),
            playersScoreTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

//extension CompetitionTableView
extension CompetitionTableView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberOfItemsInSection = 0
        if collectionView == tableCollectionView {
            numberOfItemsInSection = 4
        } else {
            numberOfItemsInSection = 1
        }
        return numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == tableCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .white
            cell.layer.borderWidth = 2
            
            if indexPath.row == indexPath.section  {
                cell.backgroundColor = .black
            }
            
            return cell
        } else if collectionView == playersNamesTableView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .green
            cell.layer.borderWidth = 2
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .yellow
            cell.layer.borderWidth = 2
            return cell
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        if cell?.backgroundColor == .white {
            print(indexPath)
        }
    }
    
    
}

extension CompetitionTableView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == tableCollectionView {
            let size = collectionView.frame.size
            return CGSize(width: (size.width-5)/4, height: (size.height)/4)
        } else {
            let size = collectionView.frame.size
            return CGSize(width: size.width, height: size.height/4)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
